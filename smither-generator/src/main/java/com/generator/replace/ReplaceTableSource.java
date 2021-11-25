package com.generator.replace;

import com.code.smither.project.base.ProjectConfig;
import com.code.smither.project.base.api.MetaDataColumn;
import com.code.smither.project.base.api.MetaDataTable;
import com.code.smither.project.database.api.DbDataSource;
import com.code.smither.project.database.impl.DbTableSource;
import com.generator.replace.model.ReplaceColumn;
import com.generator.replace.model.ReplaceTable;

public class ReplaceTableSource extends DbTableSource {

    public ReplaceTableSource(ProjectConfig config, DbDataSource dataSource) {
        super(config, dataSource);
    }

    @Override
    protected MetaDataTable newMetaDataTable() {
        return new ReplaceTable();
    }

    @Override
    protected MetaDataColumn newMetaDataColumn() {
        return new ReplaceColumn();
    }
    
}
