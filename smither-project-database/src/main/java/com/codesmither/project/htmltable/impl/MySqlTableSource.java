package com.codesmither.project.htmltable.impl;

import com.codesmither.project.base.ProjectConfig;
import com.codesmither.project.base.api.DbFactory;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * MySql 数据库 表源
 * Created by SCWANG on 2016/8/1.
 */
public class MySqlTableSource extends DbTableSource {

    public MySqlTableSource(ProjectConfig config, DbFactory dbFactory) {
        this(config, dbFactory, false);
    }

    public MySqlTableSource(ProjectConfig config, DbFactory dbFactory, boolean autoclose) {
        super(config, dbFactory, autoclose);
    }

    protected String getTableRemarks(String table) throws SQLException {
        try (Statement statement = this.connection.createStatement()){
            ResultSet rs = statement.executeQuery("SHOW CREATE TABLE `" + table+"`");
            if (rs.next()) {
                String createDDL = rs.getString(2);
                String comment = null;
                int index = createDDL.indexOf("COMMENT='");
                if (index > 0) {
                    comment = createDDL.substring(index + 9);
                    comment = comment.substring(0, comment.length() - 1);
                }
                return comment;
            }
            rs.close();
        }
        return null;
    }

}
