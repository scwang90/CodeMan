package com.codesmither.factory;

import java.sql.Connection;
import java.sql.SQLException;

import javax.sql.DataSource;

import com.mchange.v2.c3p0.ComboPooledDataSource;

/**
 * C3p0数据库链接池
 * Created by SCWANG on 2015-07-04.
 */
public class C3P0Factory {

    private static ComboPooledDataSource dataSource = null;
    // 使用ThreadLocal存储当前线程中的Connection对象
    private static ThreadLocal<Connection> threadLocal = new ThreadLocal<Connection>();

    // 在静态代码块中创建数据库连接池
    public static void load(String name) {
        if (name==null||name.trim().length()==0||"null".equals(name)||"[null]".equals(name)) {
            dataSource = null;
        } else if (name != null && name.trim().length() > 0) {
            dataSource = new ComboPooledDataSource(name);
        } else {
            dataSource = new ComboPooledDataSource();
        }
    }

    /**
     * 从数据源中获取数据库连接
     * @return Connection
     * @throws SQLException
     */
    public static Connection getConnection() throws SQLException {
        // 从当前线程中获取Connection
        Connection conn = threadLocal.get();
        if (conn == null && getDataSource() != null) {
            // 从数据源中获取数据库连接
            conn = getDataSource().getConnection();
            // 将conn绑定到当前线程
            threadLocal.set(conn);
        }
        return conn;
    }

    public static String getJdbcUrl() {
        if (dataSource == null) return "";
        return dataSource.getJdbcUrl();
    }

    public static String getDriverClass() {
        if (dataSource == null) return "";
        return dataSource.getDriverClass();
    }

    public static String getPassword() {
        if (dataSource == null) return "";
        return dataSource.getPassword();
    }

    public static String getUser() {
        if (dataSource == null) return "";
        return dataSource.getUser();
    }

    /**
     * 开启事务
     * @throws SQLException
     */
    public static void startTransaction() throws SQLException {
        // 开启事务
        getConnection().setAutoCommit(false);
    }

    /**
     * 回滚事务
     * @throws SQLException
     */
    public static void rollback() throws SQLException {
        // 从当前线程中获取Connection
        Connection conn = threadLocal.get();
        if (conn != null) {
            // 回滚事务
            conn.rollback();
        }
    }

    /**
     * 提交事务
     * @throws SQLException
     */
    public static void commit() throws SQLException {
        // 从当前线程中获取Connection
        Connection conn = threadLocal.get();
        if (conn != null) {
            // 提交事务
            conn.commit();
        }
    }

    /**
     * 关闭数据库连接(注意，并不是真的关闭，而是把连接还给数据库连接池)
     * @throws SQLException
     */
    public static void close() throws SQLException {
        // 从当前线程中获取Connection
        Connection conn = threadLocal.get();
        if (conn != null) {
            conn.close();
            // 解除当前线程上绑定conn
            threadLocal.remove();
        }
    }

    /**
     * 获取数据源
     * @return DataSource
     */
    public static DataSource getDataSource() {
        // 从数据源中获取数据库连接
        return dataSource;
    }
}
