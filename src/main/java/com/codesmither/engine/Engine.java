package com.codesmither.engine;

import java.io.File;
import java.io.PrintStream;
import java.sql.Connection;

import com.codesmither.factory.C3P0Factory;
import com.codesmither.kernel.ConfigConverter;
import com.codesmither.kernel.ConfigFileFilter;
import com.codesmither.kernel.api.Config;
import com.codesmither.kernel.api.Converter;
import com.codesmither.kernel.ModelBuilder;
import com.codesmither.kernel.TableBuilder;
import com.codesmither.model.Model;

/**
 * 核心引擎
 * Created by SCWANG on 2015-07-04.
 */
public class Engine {

    private Config config;
    private String templates;
    private String target;

    public Engine(Config config) {
        this.config = config;
        target = config.getTargetPath();
        templates = config.getTemplatePath();
    }

    public Engine(String templates, String target) {
        this.templates = templates;
        this.target = target;
    }

    protected void doInBackground(PrintStream print) throws Exception {

        File ftemplates = new File(templates);
        File ftarget = new File(target);
        if (!ftemplates.exists()) {
            throw new Exception("源项目不存在！");
        }
        if (!ftarget.exists() && !ftarget.mkdirs()) {
            throw new Exception("创建目标项目失败！");
        }

        C3P0Factory.load(config.getDbConfigName());
        Connection connection = C3P0Factory.getConnection();
        Converter converter = new ConfigConverter(config);
        ConfigFileFilter filter = new ConfigFileFilter(config);
        ModelBuilder modelBuilder = new ModelBuilder();
        TableBuilder tableBuilder = new TableBuilder(connection, converter);
        Model model = modelBuilder.build(config);
        model.setTables(tableBuilder.build());
        TaskTransfer transfer = new TaskTransfer(config, model, ftemplates, ftarget, filter);
        while (transfer.hasTask()) {
            print.println(transfer.doTask());
        }
        C3P0Factory.close();
    }

}
