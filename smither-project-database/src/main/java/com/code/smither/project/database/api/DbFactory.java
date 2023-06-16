package com.code.smither.project.database.api;

import java.sql.Connection;
import java.sql.SQLException;

/**
 * 数据库工厂
 * Created by SCWANG on 2016/8/1.
 */
public interface DbFactory {

    /**
     * 从数据源中获取数据库连接
     */
    Connection getConnection() throws SQLException ;
}
