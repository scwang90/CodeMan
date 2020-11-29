package com.code.smither.project.base.factory;

import com.code.smither.engine.factory.ConfigFactory;
import com.code.smither.project.base.ProjectConfig;

import java.util.Properties;

public class ProjectConfigFactory {


    public static <T extends ProjectConfig> T loadConfig(Properties properties, T config) {

        ConfigFactory.loadConfig(properties, config);

        config.setTemplateLang(properties.getProperty("code.smither.template.lang",config.getTemplateLang()));

        config.setTargetProjectName(properties.getProperty("code.smither.target.project.name",config.getTargetProjectName()));
        config.setTargetProjectAuthor(properties.getProperty("code.smither.target.project.author",config.getTargetProjectAuthor()));
        config.setTargetProjectPackage(properties.getProperty("code.smither.target.project.package",config.getTargetProjectPackage()));

        config.setFilterTable(properties.getProperty("code.smither.database.table.filter",config.getFilterTable()));
        config.setIncludeTable(properties.getProperty("code.smither.database.table.include",config.getIncludeTable()));

        config.setTablePrefix(properties.getProperty("code.smither.database.table.prefix",config.getTablePrefix()));
        config.setTableSuffix(properties.getProperty("code.smither.database.table.suffix",config.getTableSuffix()));
        config.setTableDivision(properties.getProperty("code.smither.database.table.division",config.getTableDivision()));
        config.setTableLogin(properties.getProperty("code.smither.database.table.login",config.getTableLogin()));

        config.setColumnPrefix(properties.getProperty("code.smither.database.column.prefix",config.getColumnPrefix()));
        config.setColumnSuffix(properties.getProperty("code.smither.database.column.suffix",config.getColumnSuffix()));
        config.setColumnDivision(properties.getProperty("code.smither.database.column.division",config.getColumnDivision()));

        config.setWordBreakDictPath(properties.getProperty("code.smither.word.break.dict.path", config.getWordBreakDictPath()));
        config.setWordReplaceDictPath(properties.getProperty("code.smither.word.replace.dict.path", config.getWordReplaceDictPath()));
        return config;
    }
}
