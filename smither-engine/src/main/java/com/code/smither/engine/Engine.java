package com.code.smither.engine;

import com.code.smither.engine.api.*;
import com.code.smither.engine.factory.FreemarkerFactory;
import com.code.smither.engine.util.FileUtil;
import freemarker.template.Template;
import freemarker.template.TemplateException;

import java.io.*;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import static com.code.smither.engine.factory.FreemarkerFactory.getTemplate;

/**
 * 驱动引擎
 * Created by SCWANG on 2016/8/18.
 */
@SuppressWarnings("unused")
public class Engine implements ITaskRunner {

    private IConfig config;
    private File templates;
    private File target;
    private TaskTransfer transfer;
    private PrintStream print = System.out;

    public Engine(IConfig config) {
        this.config = config.initEmptyFieldsWithDefaultValues();
        this.target = new File(config.getTargetPath());
        this.templates = new File(config.getTemplatePath());
    }

    public void setPrint(PrintStream print) {
        this.print = print;
    }

    public void launch(IModelBuilder modelBuilder) throws Exception {
        launch(modelBuilder,null);
    }

    public void launch(IModelBuilder modelBuilder, ProgressListener listener) throws Exception {
        checkWorkspace();

        IRootModel rootModel = config.getFieldFiller().fill(modelBuilder.build());
        List<ITask> tasks = config.getTaskLoader().loadTask(templates, target, config.getFileFilter());

        for (ITask task : tasks) {
            run(task, rootModel, config);
        }

//        transfer = new TaskTransfer(config, rootModel, templates, target);
//        transfer.prepareTask();
//        while (transfer.hasTask()) {
//            print.println(transfer.doTask());
//        }
    }

    private void checkWorkspace() throws Exception {
        if (!templates.exists()) {
            throw new Exception("源项目不存在:" + templates);
        }
        if (!target.exists() && !target.mkdirs()) {
            throw new Exception("创建目标项目失败:" + target);
        }
    }

    @Override
    public void run(ITask task, IRootModel root, IConfig config) throws Exception {

        Set<String> set = new LinkedHashSet<>();

        print.println(task.getTemplateFile());
        if (root.getModels() != null && root.getModels().size() > 0) {
            for (IModel model : root.getModels()) {
                root.bindModel(model);
                processTemplate(task, root, set);
            }
        } else {
            if (!task.getTemplateFile().getAbsolutePath().contains("{className}")) {
                processTemplate(task, root, set);
            }
        }
        print.println();
    }

    private void processTemplate(ITask task, IRootModel root, Set<String> set) throws TemplateException, IOException {

        Template nameTemplate = getTemplate(task.getTargetFile().getAbsolutePath());

        StringWriter writer = new StringWriter();
        nameTemplate.process(root, writer);
        String path = writer.getBuffer().toString();
        boolean isFtlFile = false;
        if (path.endsWith(".ftl")) {
            isFtlFile = true;
            path = path.substring(0, path.length() - 4);
        } else if (path.contains(".ftl.")) {
            isFtlFile = true;
            path = path.replace(".ftl.", ".");
        }

        if (!set.contains(path)) {

            print.println("  =>>" + path);

            File file = new File(path);
            if (FileUtil.isTextFile(task.getTemplateFile()) && (isFtlFile || !config.isTemplateFtlOnly())) {
                Template template = getTemplate(task.getTemplateFile());
                Writer out = getFileWriter(file);
                template.process(root, out);
                out.close();
            } else {
                FileUtil.copyFile(task.getTemplateFile(), checkPath(file));
            }
            set.add(path);
        }
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
