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
        config.setTargetProjectRemark(properties.getProperty("code.man.target.project.remark",config.getTargetProjectRemark()));
        config.setTargetProjectDetail(properties.getProperty("code.man.target.project.detail",config.getTargetProjectDetail()));
        config.setTargetProjectAuthor(properties.getProperty("code.man.target.project.author",config.getTargetProjectAuthor()));
        config.setTargetProjectPackage(properties.getProperty("code.man.target.project.package",config.getTargetProjectPackage()));

        config.setFilterTable(properties.getProperty("code.man.database.table.filter",config.getFilterTable()));
        config.setIncludeTable(properties.getProperty("code.man.database.table.include",config.getIncludeTable()));

        config.setTablePrefix(properties.getProperty("code.man.database.table.prefix",config.getTablePrefix()));
        config.setTableSuffix(properties.getProperty("code.man.database.table.suffix",config.getTableSuffix()));
        config.setTableDivision(properties.getProperty("code.man.database.table.division",config.getTableDivision()));
        config.setTableOrgan(properties.getProperty("code.man.database.table.organ",config.getTableOrgan()));
        config.setTableLogin(properties.getProperty("code.man.database.table.login",config.getTableLogin()));
        config.setTableNoCascade(properties.getProperty("code.man.database.table.no-cascade",config.getTableNoCascade()));

        config.setColumnPrefix(properties.getProperty("code.man.database.column.prefix",config.getColumnPrefix()));
        config.setColumnSuffix(properties.getProperty("code.man.database.column.suffix",config.getColumnSuffix()));
        config.setColumnDivision(properties.getProperty("code.man.database.column.division",config.getColumnDivision()));

        config.setColumnOrg(properties.getProperty("code.man.database.column.org",config.getColumnOrg()));
        config.setColumnCode(properties.getProperty("code.man.database.column.code",config.getColumnCode()));
        config.setColumnName(properties.getProperty("code.man.database.column.name",config.getColumnName()));
        config.setColumnCreate(properties.getProperty("code.man.database.column.create",config.getColumnCreate()));
        config.setColumnUpdate(properties.getProperty("code.man.database.column.update",config.getColumnUpdate()));
        config.setColumnRemove(properties.getProperty("code.man.database.column.remove",config.getColumnRemove()));
        config.setColumnPassword(properties.getProperty("code.man.database.column.password", config.getColumnPassword()));
        config.setColumnUsername(properties.getProperty("code.man.database.column.username",config.getColumnUsername()));
        config.setColumnCreator(properties.getProperty("code.man.database.column.creator",config.getColumnCreator()));
        config.setColumnSearch(properties.getProperty("code.man.database.column.search",config.getColumnSearch()));
        config.setColumnGender(properties.getProperty("code.man.database.column.gender",config.getColumnGender()));
        config.setColumnForceUseLong(properties.getProperty("code.man.database.column.force-use-long", config.getColumnForceUseLong()));
        config.setColumnHideForClient(properties.getProperty("code.man.database.column.hide-for-client",config.getColumnHideForClient()));
        config.setColumnHideForSubmit(properties.getProperty("code.man.database.column.hide-for-submit",config.getColumnHideForSubmit()));
        config.setColumnHideForTables(properties.getProperty("code.man.database.column.hide-for-tables",config.getColumnHideForTables()));
        config.setColumnForceUseLong(properties.getProperty("code.man.database.column.forceUseLong", config.getColumnForceUseLong()));
        config.setColumnHideForClient(properties.getProperty("code.man.database.column.hideForClient",config.getColumnHideForClient()));
        config.setColumnHideForSubmit(properties.getProperty("code.man.database.column.hideForSubmit",config.getColumnHideForSubmit()));
        config.setColumnHideForTables(properties.getProperty("code.man.database.column.hideForTables",config.getColumnHideForTables()));

        config.setWordBreakDictPath(properties.getProperty("code.man.word.break.dict.path", config.getWordBreakDictPath()));
        config.setWordReplaceDictPath(properties.getProperty("code.man.word.replace.dict.path", config.getWordReplaceDictPath()));

        config.setSmartFindId("true".equalsIgnoreCase(properties.getProperty("code.man.project.smart-find-id", "true")));

        return config;
    }
}
