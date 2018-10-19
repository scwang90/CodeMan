package com.code.smither.factory.api;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

/**
 * 数据库工厂
 * Created by SCWANG on 2016/8/1.
 */
public interface DbFactory {

    /**
     * 获取数据源
     */
    DataSource getDataSource() ;
    /**
     * 从数据源中获取数据库连接
     */
    Connection getConnection() throws SQLException ;
    /**
     * 开启事务
     */
    void startTransaction() throws SQLException ;
    /**
     * 回滚事务
     */
    void rollback() throws SQLException ;
    /**
     * 提交事务
     */
    void commit() throws SQLException ;
    /**
     * 关闭数据库连接(注意，并不是真的关闭，而是把连接还给数据库连接池)
     */
    void close() throws SQLException ;

    String getJdbcUrl() ;
    String getDriverClass() ;
    String getPassword() ;
    String getUser() ;
    
}
