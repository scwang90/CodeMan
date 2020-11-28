package com.code.smither.engine;

import com.code.smither.engine.api.FileFilter;
import com.code.smither.engine.api.*;
import com.code.smither.engine.impl.DefaultTask;
import com.code.smither.engine.util.FileUtil;
import com.code.smither.engine.util.LoggerUtil;
import freemarker.template.Template;
import freemarker.template.TemplateException;
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

    private static final Pattern condition = Pattern.compile("\\$if\\{([^=]+)=([^=]+)}");

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

        FileFilter fileFilter = config.getFileFilter();
        TaskLoader taskLoader = config.getTaskLoader();
        List<Task> tasks = taskLoader.loadTask(templates, target, fileFilter, this);

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
                processTemplate(task, root, set);
            }
        } else {
            if (!task.getTemplateFile().getAbsolutePath().contains("{className}")) {
                processTemplate(task, root, set);
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
            logger.info("  =>> : " + path);
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

    /**
     * 模版文件条件选择
     * @param file 模版文件或者文件夹
     * @return true 文件达到条件 false 文件不符合条件
     */
    private boolean conditionForTemplateFile(File file) {
        Matcher matcher = condition.matcher(file.getName());
        if (matcher.find()) {
            String key = matcher.group(1);
            String value = matcher.group(2);
            try {
                Template nameTemplate = getTemplate("${"+key+"}");
                StringWriter writer = new StringWriter();
                nameTemplate.process(rootModel, writer);
                String modelValue = writer.getBuffer().toString();

                return modelValue.equals(value);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }
        return true;
    }

    @Override
    public Task build(File file, File templates, File target) {
        Matcher matcher = condition.matcher(file.getName());
        if (matcher.find()) {
            String key = matcher.group(1);
            String value = matcher.group(2);
            try {
                Template nameTemplate = getTemplate("${"+key+"}");
                StringWriter writer = new StringWriter();
                nameTemplate.process(rootModel, writer);
                String modelValue = writer.getBuffer().toString();

                if (modelValue.equals(value)) {
                    File source = new File(file.getParent(), matcher.replaceAll(""));
                    File targets = new File(source.getAbsolutePath().replace(templates.getAbsolutePath(), target.getAbsolutePath()));
                    ConditionTask task = new ConditionTask(file, targets, key, value);

                    String templateKey = task.getTargetFile().getAbsolutePath();
                    if (!conditionTaskMap.containsKey(templateKey)) {
                        conditionTaskMap.put(templateKey, task);
                    } else {
                        throw new Exception("模板条件碰撞：" + file.getAbsolutePath());
                    }
                    return task;
                }
                return null;
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }
        return new DefaultTask(file, templates, target);
    }

    private static class ConditionTask extends DefaultTask {

        public final String key;
        public final String value;

        public ConditionTask(File templates, File target, String key, String value) {
            super(templates, target);
            this.key = key;
            this.value = value;
        }
    }

}
