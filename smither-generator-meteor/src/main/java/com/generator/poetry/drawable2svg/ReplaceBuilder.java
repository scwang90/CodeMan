package com.generator.poetry.drawable2svg;

import com.code.smither.engine.api.RootModel;
import com.code.smither.project.base.model.SourceModel;
import com.code.smither.project.base.model.Table;
import com.code.smither.project.base.model.TableColumn;
import com.code.smither.project.base.util.StringUtil;
import com.code.smither.project.database.DataBaseConfig;
import com.code.smither.project.database.model.DbModelBuilder;
import com.code.smither.project.database.model.DbSourceModel;

import java.util.HashSet;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ReplaceBuilder extends DbModelBuilder {

    private final boolean isFilterChineseCloumn;

    public ReplaceBuilder(DataBaseConfig config, boolean isFilterChineseCloumn) {
        super(config, config.getDbFactory(), config.getTableSource());
        this.isFilterChineseCloumn = isFilterChineseCloumn;
    }

    @Override
    public SourceModel build() throws Exception {
        assert database != null;
        SourceModel model = build(new DbSourceModel(database.name()), config, buildTables());
        model.getJdbc().setUrl(factory.getJdbcUrl());
        model.getJdbc().setDriver(factory.getDriverClass());
        model.getJdbc().setUsername(factory.getUser());
        model.getJdbc().setPassword(factory.getPassword());

        for (Table table : model.getTables()) {
            table.setNameSql(StringUtil.camelReverse(table.getClassName(), "_"));
            if (StringUtil.isNullOrBlank(table.getComment()) && isContainsChinese(table.getName())) {
                table.setNameSqlInStr(table.getName()
                        .replace("农合", "医保")
                        .replace("门诊处方", "结算"));
            } else {
                table.setNameSqlInStr(null);
            }
            Set<String> set = new HashSet<>();
            for (TableColumn column : table.getColumns()) {
                if (!isFilterChineseCloumn || !isContainsChinese(column.getName())) {
                    column.setNameSql(StringUtil.camelReverse(column.getFieldName(), "_")
                            .replaceAll("^[CS]_", "")
                            .replaceAll("(.+)_(BEFORE|NOW|FEE|RESULT|WAY)$", "$2_$1"));
                    set.add(column.getNameSql());
                    if (StringUtil.isNullOrBlank(column.getComment()) && isContainsChinese(column.getName())) {
                        column.setNameSqlInStr(column.getName().replace("农合", "医保"));
                    } else {
                        column.setNameSqlInStr(null);
                    }
                } else {
                    column.setNameSqlInStr(null);
                    column.setNameSql(column.getName());
                }
            }
            for (TableColumn column : table.getColumns()) {
                String newName = column.getNameSql().replaceAll("^\\w_", "");
                if (!newName.equals(column.getNameSql())) {
                    if (!set.contains(newName)) {
                        column.setNameSql(newName);
                        set.add(newName);
                    } else {
                        System.out.println("发现无法转换的名称：" + column.getNameSql());
                    }
                }
            }
        }
        return model;
    }

    //方法  返回true为包含中文；false不包含
    public static boolean isContainsChinese(String str) {
        Pattern pat = Pattern.compile("[\u4e00-\u9fa5]");
        Matcher matcher = pat.matcher(str);
        boolean flg = false;
        if (matcher.find()) {
            flg = true;
        }
        return flg;
    }

}
