package com.code.smither.engine;

import com.code.smither.engine.api.FileFilter;
import com.code.smither.engine.api.*;
import com.code.smither.engine.impl.DefaultTask;
import com.code.smither.engine.tools.Tools;
import com.code.smither.engine.util.FileUtil;
import com.code.smither.engine.util.LoggerUtil;
import freemarker.ext.beans.BeansWrapper;
import freemarker.ext.beans.StringModel;
import freemarker.template.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static com.code.smither.engine.factory.FreemarkerFactory.getTemplate;

/**
 * 驱动引擎
 * Created by SCWANG on 2016/8/18.
 */
@SuppressWarnings("unused")
public class Engine<T extends EngineConfig> implements TaskRunner, TaskBuilder {

    protected T config;
    protected File target;
    protected File templates;
    protected RootModel rootModel;
    protected Map<String, ConditionTask> conditionTaskMap;
    protected Set<ConditionTask> overwriteConditionTask;

    private static final Pattern condition = Pattern.compile("\\$if\\{(.+?)}");

    private static final Logger logger = LoggerFactory.getLogger(Engine.class);

    static {
        LoggerUtil.loadLoggingConfig();
    }

    public Engine(T config) {
        config.initEmptyFieldsWithDefaultValues();
        this.config = config;
        this.target = new File(config.getTargetPath());
        this.templates = new File(config.getTemplatePath());
    }

    public void launch(ModelBuilder modelBuilder) throws Exception {
        launch(modelBuilder,null);
    }

    public void launch(ModelBuilder modelBuilder, ProgressListener listener) throws Exception {
        checkWorkspace();

        rootModel = config.getFieldFiller().fill(modelBuilder.build());

        if (rootModel.getModels().size() == 0) {
            logger.warn("构建模型数据为空");
        }

        conditionTaskMap = new LinkedHashMap<>();
        overwriteConditionTask = new LinkedHashSet<>();

        FileFilter fileFilter = config.getFileFilter();
        TaskLoader taskLoader = config.getTaskLoader();
        List<Task> tasks = taskLoader.loadTask(templates, target, fileFilter, this);

        if (!overwriteConditionTask.isEmpty()) {
            for (int i = 0; i < tasks.size(); i++) {
                Task task = tasks.get(i);
                if ((task instanceof ConditionTask) && overwriteConditionTask.contains(task)) {
                    tasks.remove(i--);
                    logger.info("排除默认条件模板：" + task.getTemplateFile().getAbsolutePath());
                }
            }
        }

        if (!conditionTaskMap.isEmpty()) {
            for (int i = 0; i < tasks.size(); i++) {
                Task task = tasks.get(i);
                if (!(task instanceof ConditionTask) && conditionTaskMap.containsKey(task.getTargetFile().getAbsolutePath())) {
                    tasks.remove(i--);
                    logger.info("排除默认条件模板：" + task.getTemplateFile().getAbsolutePath());
                }
            }
        }

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

        logger.info(task.getTemplateFile().getAbsolutePath());
        if (root.getModels() != null && root.getModels().size() > 0) {
            for (Model model : root.getModels()) {
                root.bindModel(model);
                run(task, root, set);
            }
        } else {
            //task.getTemplateFile().getAbsolutePath().contains("{className}")
            if (!root.isModelTask(task)) {
                run(task, root, set);
            }
        }
        logger.info("");
    }

    /**
     * 通过模板和模型生产目标文件
     * @param task 任务对象
     * @param root 模型
     * @param set 生成目标文件集合（用于防止重复生产相同的文件）
     * @throws TemplateException 模板过程异常
     * @throws IOException 文件读写异常
     */
    protected void run(Task task, RootModel root, Set<String> set) throws TemplateException, IOException {

        Template nameTemplate = getTemplate(task.getTargetFile().getAbsolutePath());

        StringWriter writer = new StringWriter();
        nameTemplate.process(root, writer);
        String path = writer.getBuffer().toString();
        boolean isFtlFile = false;
        if (!path.replaceAll("\\.ftl[xh]?$", "").equals(path)) {
            isFtlFile = true;
            path = path.replaceAll("\\.ftl[xh]?$", "");
        } else if (path.contains(".ftl.")) {
            isFtlFile = true;
            path = path.replace(".ftl.", ".");
        }

        //判断已经生成的目标文件集合中是否已经含有即将生成的文件
        if (!set.contains(path)) {
            Map<String, String> condition = new LinkedHashMap<>();
            if (!condition(path, condition)) {
                logger.info("条件不符 : " + path);
                return;
            }

            if (!condition.isEmpty()) {
                for (Map.Entry<String, String> entry : condition.entrySet()) {
                    path = path.replace(entry.getKey(), entry.getValue());
                }
            }

            File file = new File(path);
            if (!file.exists() || task.forceOverWrite()) {
                if (FileUtil.isTextFile(task.getTemplateFile()) && (isFtlFile || config.isTemplateProcessAll())) {
                    processTemplate(root, task.getTemplateFile(), file);
                } else {
                    copyFile(task, file);
                }
                logger.info("  =>> : " + path);
            } else {
                logger.info("已跳过 : " + path);
            }
            set.add(path);
        }
    }

    protected void copyFile(Task task, File file) throws IOException {
        FileUtil.copyFile(task.getTemplateFile(), checkPath(file));
    }

    protected void processTemplate(RootModel root, File templateFile, File file) throws IOException, TemplateException {
        try(Writer out = getFileWriter(file)) {
            Template template = getTemplate(templateFile);
            ObjectWrapper wrapper = template.getObjectWrapper();
            template.process(getDataModel(root, (BeansWrapper) wrapper), out);
        }
    }

    private StringModel getDataModel(RootModel root, BeansWrapper wrapper) {
        return new StringModel(root, wrapper) {
            @Override
            public TemplateModel get(String key) throws TemplateModelException {
                TemplateModel model = super.get(key);
                if (model == null && "tools".equals(key)) {
                    return new StringModel(getTools(), wrapper);
                }
                return model;
            }
        };
    }

    protected Tools getTools() {
        return new Tools();
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

    private boolean condition(String path, Map<String, String> conditionMap) {
        Matcher matcher = condition.matcher(path);
        while (matcher.find()) {
            try {
                String group = matcher.group();
                String magic = matcher.group(1)
                        .replaceAll("\\b=\\b", "==")
                        .replaceAll("==(\\w+)$", "=='$1'");
                Template nameTemplate = getTemplate("${(" + magic + ")?c}");
                ObjectWrapper wrapper = nameTemplate.getObjectWrapper();
                StringWriter writer = new StringWriter();
                nameTemplate.process(getDataModel(rootModel,  (BeansWrapper)wrapper), writer);
                String value = writer.getBuffer().toString();
                if (value.equals("true")) {
                    conditionMap.put(group, "");
                } else {
                    return false;
                }
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }
        return true;
    }

    @Override
    public Task build(File file, File templates, File target) {
        DefaultTask defaultTask = new DefaultTask(file, templates, target, config, rootModel);
        if (rootModel.isModelTask(defaultTask)) {
            return defaultTask;
        }
        Map<String, String> condition = new LinkedHashMap<>();
        if (!condition(file.getPath(), condition)) {
            logger.info("排除默认条件模板：" + file.getPath());
            return null;
        }
//        Matcher matcher = condition.matcher(file.getPath());
//        Map<String, String> condition = new LinkedHashMap<>();
//        while (matcher.find()) {
//            try {
//                String group = matcher.group();
//                String magic = matcher.group(1)
//                        .replaceAll("\\b=\\b", "==")
//                        .replaceAll("==(\\w+)$", "=='$1'");
//                Template nameTemplate = getTemplate("${(" + magic + ")?c}");
//                StringWriter writer = new StringWriter();
//                nameTemplate.process(rootModel, writer);
//                String value = writer.getBuffer().toString();
//                if (value.equals("true")) {
//                    condition.put(group, "");
//                } else {
//                    logger.info("排除默认条件模板：" + file.getPath());
//                    return null;
//                }
//            } catch (Exception e) {
//                throw new RuntimeException(e);
//            }
//        }
        if (!condition.isEmpty()) {
            ConditionTask task = new ConditionTask(file, templates, target, condition, config, rootModel);
            String templateKey = task.getTargetFile().getAbsolutePath();
            if (!conditionTaskMap.containsKey(templateKey)) {
                conditionTaskMap.put(templateKey, task);
            } else {
                ConditionTask conditionTask = conditionTaskMap.get(templateKey);
                if (conditionTask.condition.size() > condition.size()) {
                    logger.info("排除默认条件模板：" + task.getTemplateFile().getAbsolutePath());
                    return null;
                } else if (conditionTask.condition.size() < condition.size()) {
                    overwriteConditionTask.add(conditionTaskMap.put(templateKey, task));
                } else {
                    throw new RuntimeException("模板条件碰撞：" + file.getAbsolutePath());
                }
            }
            return task;
        }
        return defaultTask;
    }

    private static class ConditionTask extends DefaultTask {

        public final File targetFile;
        public final Map<String, String> condition;

        public ConditionTask(File file, File templates, File target, Map<String, String> condition, EngineConfig config, RootModel root) {
            super(file, templates, target, config, root);
            this.condition = condition;
            this.targetFile = buildTargetFile();
        }

        private File buildTargetFile() {
            String path = super.getTargetFile().getAbsolutePath();
            for (Map.Entry<String, String> entity : this.condition.entrySet()) {
                path = path.replace(entity.getKey(), entity.getValue());
            }
            return new File(path);
        }

        @Override
        public File getTargetFile() {
            return this.targetFile;
        }

    }

}
