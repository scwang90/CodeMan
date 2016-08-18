package com.codesmither.engine;

import com.codesmither.engine.api.IModelBuilder;
import com.codesmither.engine.api.ProgressListener;

import java.io.File;
import java.io.PrintStream;

/**
 * 驱动引擎
 * Created by SCWANG on 2016/8/18.
 */
@SuppressWarnings("unused")
public class Engine {

    private Config config;
    private File templates;
    private File target;
    private PrintStream print = System.out;

    public Engine(Config config) {
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
        TaskTransfer transfer = new TaskTransfer(config, modelBuilder, templates, target);
        transfer.prepareTask();
        while (transfer.hasTask()) {
            print.println(transfer.doTask());
        }
    }

    protected void checkWorkspace() throws Exception {
        if (!templates.exists()) {
            throw new Exception("源项目不存在:" + templates);
        }
        if (!target.exists() && !target.mkdirs()) {
            throw new Exception("创建目标项目失败:" + target);
        }
    }

}
