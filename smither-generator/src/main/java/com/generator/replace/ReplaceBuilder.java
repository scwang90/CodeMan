package com.generator.replace;

import com.code.smither.project.base.api.MetaDataTable;
import com.code.smither.project.base.model.SourceModel;
import com.code.smither.project.base.model.Table;
import com.code.smither.project.base.util.StringUtil;
import com.code.smither.project.database.model.DbModelBuilder;
import com.code.smither.project.database.model.DbSourceModel;
import com.generator.replace.model.ReplaceColumn;
import com.generator.replace.model.ReplaceTable;

import java.util.Comparator;
import java.util.HashSet;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

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
        model.getJdbc().setDriver(factory.getDriver());
        model.getJdbc().setUsername(factory.getUsername());
        model.getJdbc().setPassword(factory.getPassword());

        for (ReplaceTable table : model.getTables().stream().map(t->(ReplaceTable)t).collect(Collectors.toList())) {
            table.setReplaceName(StringUtil.camelReverse(table.getClassName(), "_"));
            if (replaceConfig.getDictRemark().containsKey(table.getName())) {
                table.setReplaceRemark(replaceConfig.getDictRemark().get(table.getName()).value);
            } else if (isContainsChinese(table.getName())) {
                String remark = table.getName().replace("农合", "医保").replace("门诊处方", "结算");
                if (StringUtil.isNullOrBlank(table.getComment())) {
                    table.setReplaceRemark(remark);
                } else {
                    table.setReplaceRemark(remark + "(" + table.getComment() + ")");
                }
            } else {
                table.setReplaceRemark(null);
            }
            Set<String> set = new HashSet<>();
            for (ReplaceColumn column : table.getColumns().stream().map(c->(ReplaceColumn)c).collect(Collectors.toList())) {
                if (!isFilterChineseCloumn || !isContainsChinese(column.getName())) {
                    column.setReplaceName(StringUtil.camelReverse(column.getFieldName(), "_")
                            .replaceAll("(.+)_(BEFORE|NOW|FEE|RESULT|WAY)$", "$2_$1"));
                    set.add(column.getNameSql());
                    if (StringUtil.isNullOrBlank(column.getComment()) && isContainsChinese(column.getName())) {
                        column.setReplaceRemark(column.getName().replace("农合", "医保"));
                    } else {
                        column.setReplaceRemark(null);
                    }
                } else {
                    column.setReplaceRemark(null);
                    column.setReplaceName(column.getName());
                    set.add(column.getReplaceName());
                }
            }
            for (ReplaceColumn column : table.getColumns().stream().map(c->(ReplaceColumn)c).collect(Collectors.toList())) {
                String newName = column.getReplaceName().replaceAll("^\\w_", "");
                if (!newName.equals(column.getReplaceName())) {
                    if (!set.contains(newName)) {
                        column.setReplaceName(newName);
                        set.add(newName);
                    } else {
                        System.out.println("发现无法转换的名称：" + column.getReplaceName());
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
