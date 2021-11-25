package com.generator.replace;


import com.code.smither.project.base.model.SourceModel;
import com.code.smither.project.base.model.Table;
import com.code.smither.project.base.model.TableColumn;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ReplaceDictionaryBuilder extends ReplaceBuilder {

    public ReplaceDictionaryBuilder(ReplaceConfig config, boolean isFilterChineseCloumn) {
        super(config, isFilterChineseCloumn);
    }

    @Override
    public SourceModel build() throws Exception {
        SourceModel model = super.build();
        Map<String, String> map = new HashMap<>();
        for (Table table : model.getTables()) {
            for (TableColumn column : table.getColumns()) {
                if (!column.getName().equals(column.getNameSql())) {
                    map.put(column.getName(), column.getNameSql());
                }
            }
            if (!table.getName().equals(table.getNameSql())) {
                map.put(table.getName(), table.getNameSql());
            }
        }
        List<Table> tables = new ArrayList<>(map.size());
        for (Map.Entry<String, String> entry : map.entrySet()) {
            Table table = new Table();
            table.setName(entry.getKey());
            table.setNameSql(entry.getValue());
            tables.add(table);
        }
        model.setTables(tables);
        return model;
    }
}
