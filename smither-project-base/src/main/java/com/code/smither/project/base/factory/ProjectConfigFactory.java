package com.code.smither.project.base.factory;

import com.code.smither.engine.factory.ConfigFactory;
import com.code.smither.project.base.ProjectConfig;

import java.util.Properties;

public class ProjectConfigFactory {


    public static <T extends ProjectConfig> T loadConfig(Properties properties, T config) {

        ConfigFactory.loadConfig(properties, config);

        config.setTemplateLang(properties.getProperty("code.man.template.lang",config.getTemplateLang()));

        config.setTargetProjectName(properties.getProperty("code.man.target.project.name",config.getTargetProjectName()));
        config.setTargetProjectAuthor(properties.getProperty("code.man.target.project.author",config.getTargetProjectAuthor()));
        config.setTargetProjectPackage(properties.getProperty("code.man.target.project.package",config.getTargetProjectPackage()));

        config.setFilterTable(properties.getProperty("code.man.database.table.filter",config.getFilterTable()));
        config.setIncludeTable(properties.getProperty("code.man.database.table.include",config.getIncludeTable()));

        config.setTablePrefix(properties.getProperty("code.man.database.table.prefix",config.getTablePrefix()));
        config.setTableSuffix(properties.getProperty("code.man.database.table.suffix",config.getTableSuffix()));
        config.setTableDivision(properties.getProperty("code.man.database.table.division",config.getTableDivision()));
        config.setTableLogin(properties.getProperty("code.man.database.table.login",config.getTableLogin()));

        config.setColumnPrefix(properties.getProperty("code.man.database.column.prefix",config.getColumnPrefix()));
        config.setColumnSuffix(properties.getProperty("code.man.database.column.suffix",config.getColumnSuffix()));
        config.setColumnDivision(properties.getProperty("code.man.database.column.division",config.getColumnDivision()));
        config.setColumnCreate(properties.getProperty("code.man.database.column.create",config.getColumnCreate()));
        config.setColumnUpdate(properties.getProperty("code.man.database.column.update",config.getColumnUpdate()));

        config.setWordBreakDictPath(properties.getProperty("code.man.word.break.dict.path", config.getWordBreakDictPath()));
        config.setWordReplaceDictPath(properties.getProperty("code.man.word.replace.dict.path", config.getWordReplaceDictPath()));
        return config;
    }
}
