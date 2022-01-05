package com.generator.replace;

import com.code.smither.project.base.api.WordReplacer;
import com.code.smither.project.base.model.SourceModel;
import com.code.smither.project.base.model.Table;
import com.code.smither.project.base.util.StringUtil;
import com.code.smither.project.database.model.DbModelBuilder;
import com.code.smither.project.database.model.DbSourceModel;
import com.generator.replace.model.ReplaceColumn;
import com.generator.replace.model.ReplaceTable;

import java.util.Comparator;
import java.util.HashSet;
import java.util.Map;
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
    protected Table tableCompute(Table table) throws Exception {
        isIgnoreCurrentTable = replaceConfig.getDictTableIgnore().containsKey(table.getName());
        return super.tableCompute(table);
    }

    @Override
    protected String convertIfNeed(String name) {
        if (isIgnoreCurrentTable) {
            return name;
        }
        return super.convertIfNeed(name);
    }

    @Override
    protected String convertTableIfNeed(String name) {
        // if (replaceConfig.getDictTableName().containsKey(table.getName())) {
        //     table.setReplaceName(replaceConfig.getDictTableRemark().get(table.getName()).value);
        // }
        return name;
        // return super.convertTableIfNeed(name);
    }

    @Override
    protected String convertColumnIfNeed(String name) {
        // if (replaceConfig.getDictColumnName().containsKey(column.getName())) {
        //     replaceConfig.getDictColumnName().get(table.getName()).
        //     table.setReplaceRemark(replaceConfig.getDictTableRemark().get(table.getName()).value);
        // }
        return name;
        // return super.convertColumnIfNeed(name);
    }

    @Override
    public SourceModel build() throws Exception {
        assert database != null;
        SourceModel model = build(new DbSourceModel(database.name()), config, buildTables());
        model.getJdbc().setUrl(factory.getJdbcUrl());
        model.getJdbc().setDriver(factory.getDriver());
        model.getJdbc().setUsername(factory.getUsername());
        model.getJdbc().setPassword(factory.getPassword());

        WordReplacer replacerTableName = replaceConfig.getReplacerTableName();
        WordReplacer replacerColumnName = replaceConfig.getReplacerColumnName();
        WordReplacer replacerTableRemark = replaceConfig.getReplacerTableRemark();
        Map<String, String> dictTableIgnore = replaceConfig.getDictTableIgnore();
        for (ReplaceTable table : model.getTables().stream().map(t->(ReplaceTable)t).collect(Collectors.toList())) {
            //忽略表过滤
            if (dictTableIgnore.containsKey(table.getName())) {
                table.setReplaceName(table.getName());
                for (ReplaceColumn column : table.getColumns().stream().map(c->(ReplaceColumn)c).collect(Collectors.toList())) {
                    column.setReplaceName(column.getName());
                }
                continue;
            }
            String newTableName = replacerTableName.replace(table.getName(), config.getTableDivision());
            newTableName = newTableName.replaceAll("^_+|_+$", "").replaceAll("__+", "_").toUpperCase();
            if (!table.getName().equals(newTableName)) {
                table.setReplaceName(newTableName);
            } else {
                //没有被替换
                newTableName = super.convertIfNeed(table.getName());
                newTableName = newTableName.replaceAll("^_+|_+$", "").replaceAll("__+", "_").toUpperCase();
                if (!table.getName().equals(newTableName)) {
                    table.setReplaceName(newTableName);
                } else {
                    //默认类名反驼峰
                    table.setReplaceName(StringUtil.camelReverse(table.getClassName(), "_"));
                }
            }
            //表备注
            if (replacerTableRemark.containsKey(table.getName())) {
                table.setReplaceRemark(replacerTableRemark.replace(table.getName()));
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
                    String newColumnName = replacerColumnName.replace(column.getName(), config.getColumnDivision());
                    if (!column.getName().equals(newColumnName)) {
                        newColumnName = super.convertIfNeed(newColumnName);
                    } else {
                        //没有被替换
                        newColumnName = super.convertIfNeed(column.getName());
                        if (column.getName().equals(newColumnName)) {
                            //默认类名反驼峰
                            newColumnName = StringUtil.camelReverse(column.getFieldName(), config.getColumnDivision());
                            newColumnName = newColumnName.replaceAll("(.+)_(BEFORE|NOW|FEE|RESULT|WAY)$", "$2_$1");
                        }
                    }
                    if (!StringUtil.isNullOrBlank(config.getColumnDivision())) {
                        newColumnName = StringUtil.camelReverse(newColumnName, config.getColumnDivision());
                        if (newColumnName.contains(config.getColumnDivision())) {
                            newColumnName = newColumnName.toUpperCase();
                        }
                    }
                    newColumnName = newColumnName.replaceAll("^_+|_+$", "").replaceAll("__+", "_");
                    set.add(newColumnName);
                    column.setReplaceName(newColumnName);
                    if (isContainsChinese(column.getName())) {
                        String remark = column.getName().replace("农合", "医保").replace("门诊处方", "结算");
                        if (StringUtil.isNullOrBlank(column.getComment()) || remark.equals(column.getComment())) {
                            column.setReplaceRemark(remark);
                        } else {
                            column.setReplaceRemark(remark + "(" + column.getComment() + ")");
                        }
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
        model.getTables().sort(Comparator.comparing(t -> {
            if (t == null) {
                return "";
            }
            if (t instanceof ReplaceTable){
                ReplaceTable table = (ReplaceTable)t;
                return table.getReplaceName() + "";
            }
            return t.getName() + "";
        }));
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
