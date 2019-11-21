package com.code.smither.engine;

import com.code.smither.engine.api.*;
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
public class Engine implements TaskRunner {

    private Config config;
    private File templates;
    private File target;
    private TaskTransfer transfer;
    private PrintStream print = System.out;

    public Engine(Config config) {
        this.config = config.initEmptyFieldsWithDefaultValues();
        this.target = new File(config.getTargetPath());
        this.templates = new File(config.getTemplatePath());
    }

    public void setPrint(PrintStream print) {
        this.print = print;
    }

    public void launch(ModelBuilder modelBuilder) throws Exception {
        launch(modelBuilder,null);
    }

    public void launch(ModelBuilder modelBuilder, ProgressListener listener) throws Exception {
        checkWorkspace();

        RootModel rootModel = config.getFieldFiller().fill(modelBuilder.build());

        if (rootModel.getModels().size() == 0) {
            System.err.println("构建模型数据为空");
        }

        List<Task> tasks = config.getTaskLoader().loadTask(templates, target, config.getFileFilter());

        for (Task task : tasks) {
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
    public void run(Task task, RootModel root, Config config) throws Exception {

        //定义生成目标文件集合（用于防止重复生产相同的文件）
        Set<String> set = new LinkedHashSet<>();

        print.println(task.getTemplateFile());
        if (root.getModels() != null && root.getModels().size() > 0) {
            for (Model model : root.getModels()) {
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

    /**
     * 通过模板和模型生产目标文件
     * @param task 任务对象
     * @param root 模型
     * @param set 生成目标文件集合（用于防止重复生产相同的文件）
     * @throws TemplateException 模板过程异常
     * @throws IOException 文件读写异常
     */
    private void processTemplate(Task task, RootModel root, Set<String> set) throws TemplateException, IOException {

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

        //判断已经生成的目标文件集合中是否已经含有即将生成的文件
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
