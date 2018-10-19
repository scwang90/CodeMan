package com.code.smither.engine;

import com.code.smither.engine.api.*;
import com.code.smither.engine.factory.FreemarkerFactory;
import com.code.smither.engine.util.FileUtil;
import com.code.smither.engine.util.Reflecter;
import freemarker.template.Template;
import freemarker.template.TemplateException;

import java.io.*;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 任务执行转换器
 * Created by SCWANG on 2016/8/18.
 */
public class TaskTransfer {

    private int taskNo = 0;
    private IConfig config;
    private final File templates;
    private final File target;
    private IRootModel rootModel;
    private List<ITask> tasks;

    public TaskTransfer(IConfig config, IRootModel rootModel, File templates, File target) {
        this.config = config;
        this.target = target;
        this.templates = templates;
        this.rootModel = rootModel;
    }

    private IFileFilter buildFilter(IConfig config) {
        return config.getFileFilter();
    }

    public void prepareTask() throws Exception{
        if (tasks == null) {
            this.rootModel = fillEmptyFields(rootModel);
            this.tasks = config.getTaskLoader().loadTask(templates, target, buildFilter(config));
        }
    }

    /**
     * 填充空字段 防止发送异常
     */
    private IRootModel fillEmptyFields(IRootModel model) {
        return config.getFieldFiller().fill(model);
    }

    public boolean hasTask() throws Exception {
        checkPrepareTask("hasTask");
        return taskNo < tasks.size();
    }

    private void checkPrepareTask(String domain) {
        if (rootModel == null) {
            throw new RuntimeException("调用【"+domain+"】之前必须先调用【prepareTask】");
        }
    }

    public String doTask() throws IOException, TemplateException {
        checkPrepareTask("doTask");
        ITask task = tasks.get(taskNo++);
        File outfile = task.getTargetFile();

        StringBuilder log = new StringBuilder(outfile.getAbsolutePath()+"\r\n");
        if (task.getTemplateFile().getName().matches("\\w+\\.\\w+\\.\\w+\\.ftl")) {
            String path = replacePath(outfile.getAbsolutePath().replaceAll("\\.\\w*\\.ftl",""));
            log.append("  =>>");
            log.append(path);
            log.append("\r\n");
            Template template = getTemplate(task.getTemplateFile());
            Writer out = getFileWriter(new File(path));
            template.process(rootModel, out);
            out.close();
        } else if (task.getTemplateFile().getName().endsWith(".ftl")) {

            Set<String> set = new LinkedHashSet<>();
            Template template = getTemplate(task.getTemplateFile());
            Template nameTemplate = FreemarkerFactory.getTemplate(outfile.getAbsolutePath());
            for (IModel model : rootModel.getModels()) {
                rootModel.bindModel(model);
                StringWriter writer = new StringWriter();
                nameTemplate.process(rootModel, writer);
                String name = writer.getBuffer().toString();
                if (!set.contains(name)) {
                    File file = new File(name.replace(".ftl", ""));
                    log.append("  =>>");
                    log.append(file.getAbsolutePath());
                    log.append("\r\n");
                    Writer out = getFileWriter(file);
                    template.process(rootModel, out);
                    out.close();
                }
                set.add(name);
            }

//            Template template = getTemplate(task.getTemplateFile());
//
//            for (IModel model : rootModel.getModels()) {
//                rootModel.bindModel(model);
//                String path = replacePath(outfile.getAbsolutePath().replace(".ftl", ""));
//                log.append("  =>>");
//                log.append(path);
//                log.append("\r\n");
//                Writer out = getFileWriter(new File(path));
//                template.process(rootModel, out);
//                out.close();
//            }
        } else if(FileUtil.isTextFile(task.getTemplateFile())){
            String path = replacePath(outfile.getAbsolutePath());
            log.append("  =>>");
            log.append(path);
            log.append("\r\n");
            Template template = getTemplate(task.getTemplateFile());
            Writer out = getFileWriter(new File(path));
            template.process(rootModel, out);
            out.close();
        } else {
            String path = replacePath(outfile.getAbsolutePath());
            log.append("  =>>");
            log.append(path);
            log.append("\r\n");
            FileInputStream inputStream = new FileInputStream(task.getTemplateFile());
            FileOutputStream outputStream = new FileOutputStream(checkPath(new File(path)));
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

//    private List<Map.Entry<String, IModel>> loadModels(ITask task) throws Exception {
//        Set<String> set = new LinkedHashSet<>();
//        List<Map.Entry<String, IModel>> models = new ArrayList<>();
//        Template template = FreemarkerFactory.getTemplate(task.getTemplateFile().getName());
//        for (IModel model : rootModel.getModels()) {
//            rootModel.bindModel(model);
//            StringWriter writer = new StringWriter();
//            template.process(rootModel, writer);
//            String name = writer.getBuffer().toString();
//            if (!set.contains(name)) {
//
//            }
//            set.add(name);
//        }
//        return models;
//    }

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
        checkPath(file);
        String charset = config.getTargetCharset();
        if (charset != null && charset.trim().length() > 0) {
            return new OutputStreamWriter(new FileOutputStream(file),charset);
        }
        return new FileWriter(file);
    }

    private File checkPath(File file) {
        File path = file.getParentFile();
        if (!path.exists() && !path.mkdirs()) {
            throw new RuntimeException("创建目标目录失败："+path);
        }
        return file;
    }
}
