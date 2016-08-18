package com.codesmither.engine;

import com.codesmither.engine.api.*;
import com.codesmither.engine.factory.FreemarkerFactory;
import com.codesmither.engine.util.FileUtil;
import com.codesmither.engine.util.Reflecter;
import freemarker.template.Template;
import freemarker.template.TemplateException;

import java.io.*;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 任务执行转换器
 * Created by SCWANG on 2016/8/18.
 */
public class TaskTransfer {

    private int itask = 0;
    private Config config;
    private final File templates;
    private final File target;
    private final IModelBuilder modelBuilder;
    private IRootModel rootModel;
    private List<ITask> tasks;

    public TaskTransfer(Config config, IModelBuilder modelBuilder, File templates, File target) {
        this.config = config;
        this.target = target;
        this.templates = templates;
        this.modelBuilder = modelBuilder;
    }

    private IFileFilter buildFilter(Config config) {
        if (config instanceof IFilterConfig) {
            return config.getFileFilterFactory().build(((IFilterConfig) config));
        }
        return config.getFileFilterFactory().build(null);
    }

    public void prepareTask() throws Exception{
        if (rootModel == null) {
            this.rootModel = modelBuilder.build();
            this.tasks = config.getTaskLoader().loadTask(templates, target, buildFilter(config));
        }
    }

    public boolean hasTask() throws Exception {
        checkPrepareTask("hasTask");
        return itask < tasks.size();
    }

    private void checkPrepareTask(String domain) {
        if (rootModel == null) {
            throw new RuntimeException("调用【"+domain+"】之前必须先调用【prepareTask】");
        }
    }

    public String doTask() throws IOException, TemplateException {
        checkPrepareTask("doTask");
        ITask task = tasks.get(itask++);
        File outfile = task.getTargetFile();

        StringBuilder log = new StringBuilder(outfile.getAbsolutePath()+"\r\n");
        if (task.getTemplateFile().getName().endsWith(".ftl")) {
            Template template = getTemplate(task.getTemplateFile());
            for (IModel model : rootModel.getModels()) {
                rootModel.bindModel(model);
                String outpath = replacePath(outfile.getAbsolutePath().replace(".ftl", ""));
                log.append("  =>>");
                log.append(outpath);
                log.append("\r\n");
                Writer out = getFileWriter(new File(outpath));
                template.process(rootModel, out);
                out.close();
            }
        } else if(FileUtil.isTextFile(task.getTemplateFile())){
            String outpath = replacePath(outfile.getAbsolutePath());
            log.append("  =>>");
            log.append(outpath);
            log.append("\r\n");
            Template template = getTemplate(task.getTemplateFile());
            Writer out = getFileWriter(new File(outpath));
            template.process(rootModel, out);
            out.close();
        } else {
            String outpath = replacePath(outfile.getAbsolutePath());
            log.append("  =>>");
            log.append(outpath);
            log.append("\r\n");
            FileInputStream inputStream = new FileInputStream(task.getTemplateFile());
            FileOutputStream outputStream = new FileOutputStream(new File(outpath));
            byte[] bytes = new byte[inputStream.available()];
            if (inputStream.read(bytes) > 0) {
                outputStream.write(bytes);
            }
            outputStream.close();
            inputStream.close();
            System.gc();
        }
        return log.toString();
    }

    private String replacePath(String outpath) {
        Matcher matcher = Pattern.compile("\\$\\{([a-zA-Z0-9\\.]+)\\}", Pattern.CASE_INSENSITIVE).matcher(outpath);
        while (matcher.find()) {
            String group = matcher.group(1);
            Object value = Reflecter.getMemberNoException(rootModel, group);
            if (value != null) {
                outpath = outpath.replace("${" + group + "}", value.toString());
            } else {
                throw new RuntimeException("未找到${" + group + "}替换值");
            }
        }
        return outpath;
    }

    private Template getTemplate(File file) throws IOException {
        String charset = config.getTemplateCharset();
        if (charset != null && charset.trim().length() > 0) {
            return FreemarkerFactory.getTemplate(file, charset);
        }
        return FreemarkerFactory.getTemplate(file);
    }

    private Writer getFileWriter(File file) throws IOException{
        File path = file.getParentFile();
        if (!path.exists() && !path.mkdirs()) {
            throw new RuntimeException("创建目标目录失败："+path);
        }
        String charset = config.getTargetCharset();
        if (charset != null && charset.trim().length() > 0) {
            return new OutputStreamWriter(new FileOutputStream(file),charset);
        }
        return new FileWriter(file);
    }
}
