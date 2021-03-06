package com.code.smither.project.base.factory;

import com.code.smither.engine.factory.ConfigFactory;
import com.code.smither.project.base.ProjectConfig;

import java.util.Properties;

public class ProjectConfigFactory {


    public static <T extends ProjectConfig> T loadConfig(Properties properties, T config) {

        ConfigFactory.loadConfig(properties, config);

        config.setTemplateLang(properties.getProperty("code.man.template.lang",config.getTemplateLang()));

        config.setTargetFeatures(properties.getProperty("code.man.target.features",config.getTargetFeatures()));
        config.setTargetProjectName(properties.getProperty("code.man.target.project.name",config.getTargetProjectName()));
        config.setTargetProjectAuthor(properties.getProperty("code.man.target.project.author",config.getTargetProjectAuthor()));
        config.setTargetProjectPackage(properties.getProperty("code.man.target.project.package",config.getTargetProjectPackage()));

        config.setFilterTable(properties.getProperty("code.man.database.table.filter",config.getFilterTable()));
        config.setIncludeTable(properties.getProperty("code.man.database.table.include",config.getIncludeTable()));

        config.setTablePrefix(properties.getProperty("code.man.database.table.prefix",config.getTablePrefix()));
        config.setTableSuffix(properties.getProperty("code.man.database.table.suffix",config.getTableSuffix()));
        config.setTableDivision(properties.getProperty("code.man.database.table.division",config.getTableDivision()));
        config.setTableOrgan(properties.getProperty("code.man.database.table.organ",config.getTableOrgan()));
        config.setTableLogin(properties.getProperty("code.man.database.table.login",config.getTableLogin()));
        config.setTableNoCascade(properties.getProperty("code.man.database.table.nocascade",config.getTableNoCascade()));

        config.setColumnPrefix(properties.getProperty("code.man.database.column.prefix",config.getColumnPrefix()));
        config.setColumnSuffix(properties.getProperty("code.man.database.column.suffix",config.getColumnSuffix()));
        config.setColumnDivision(properties.getProperty("code.man.database.column.division",config.getColumnDivision()));

        config.setColumnOrg(properties.getProperty("code.man.database.column.org",config.getColumnOrg()));
        config.setColumnCode(properties.getProperty("code.man.database.column.code",config.getColumnCode()));
        config.setColumnCreate(properties.getProperty("code.man.database.column.create",config.getColumnCreate()));
        config.setColumnUpdate(properties.getProperty("code.man.database.column.update",config.getColumnUpdate()));
        config.setColumnRemove(properties.getProperty("code.man.database.column.remove",config.getColumnRemove()));
        config.setColumnPassword(properties.getProperty("code.man.database.column.password",config.getColumnPassword()));
        config.setColumnUsername(properties.getProperty("code.man.database.column.username",config.getColumnUsername()));
        config.setColumnCreator(properties.getProperty("code.man.database.column.creator",config.getColumnCreator()));
        config.setColumnSearches(properties.getProperty("code.man.database.column.searches",config.getColumnSearches()));
        config.setColumnGender(properties.getProperty("code.man.database.column.gender",config.getColumnGender()));
        config.setColumnHideForClient(properties.getProperty("code.man.database.column.hide-for-client",config.getColumnHideForClient()));
        config.setColumnHideForSubmit(properties.getProperty("code.man.database.column.hide-for-submit",config.getColumnHideForSubmit()));
        config.setColumnHideForClient(properties.getProperty("code.man.database.column.hideForClient",config.getColumnHideForClient()));
        config.setColumnHideForSubmit(properties.getProperty("code.man.database.column.hideForSubmit",config.getColumnHideForSubmit()));

        config.setWordBreakDictPath(properties.getProperty("code.man.word.break.dict.path", config.getWordBreakDictPath()));
        config.setWordReplaceDictPath(properties.getProperty("code.man.word.replace.dict.path", config.getWordReplaceDictPath()));
        return config;
    }
}
