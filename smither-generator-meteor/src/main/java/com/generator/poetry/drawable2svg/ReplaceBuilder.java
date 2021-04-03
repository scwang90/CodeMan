package com.generator.poetry.drawable2svg;

import com.code.smither.engine.api.RootModel;
import com.code.smither.project.base.api.MetaDataTable;
import com.code.smither.project.base.model.SourceModel;
import com.code.smither.project.base.model.Table;
import com.code.smither.project.base.model.TableColumn;
import com.code.smither.project.base.util.StringUtil;
import com.code.smither.project.database.DataBaseConfig;
import com.code.smither.project.database.model.DbModelBuilder;
import com.code.smither.project.database.model.DbSourceModel;

import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ReplaceBuilder extends DbModelBuilder {

    private final boolean isFilterChineseCloumn;
    private final ReplaceConfig replaceConfig;

    private boolean isIgnoreCurrentTable = false;

    public ReplaceBuilder(ReplaceConfig config, boolean isFilterChineseCloumn) {
        super(config, config.getDbFactory(), config.getTableSource());
        this.replaceConfig = config;
        this.isFilterChineseCloumn = isFilterChineseCloumn;
    }

    @Override
    protected Table tableCompute(Table table, MetaDataTable tableMate) throws Exception {
        isIgnoreCurrentTable = replaceConfig.getDictIgnore().containsKey(table.getName());
        return super.tableCompute(table, tableMate);
    }

    @Override
    protected String convertIfNeed(String name) {
        if (isIgnoreCurrentTable) {
            return name;
        }
        return super.convertIfNeed(name);
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
            if (replaceConfig.getDictRemark().containsKey(table.getName())) {
                table.setNameSqlInStr(replaceConfig.getDictRemark().get(table.getName()).value);
            } else if (StringUtil.isNullOrBlank(table.getComment()) && isContainsChinese(table.getName())) {
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
                    set.add(column.getNameSql());
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
        model.getTables().sort(Comparator.comparing(Table::getNameSql));
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
