package com.codesmither.project.database.factory;

import com.codesmither.project.base.api.DbFactory;
import com.mchange.v2.c3p0.ComboPooledDataSource;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;

/**
 * C3p0数据库链接池
 * Created by SCWANG on 2015-07-04.
 */
public class C3P0Factory implements DbFactory {

    private static HashMap<String, C3P0Factory> instances = new HashMap<>();

    private ComboPooledDataSource dataSource = null;
    // 使用ThreadLocal存储当前线程中的Connection对象
    private ThreadLocal<Connection> threadLocal = new ThreadLocal<>();

    protected C3P0Factory(String name) {
        if (name == null || name.trim().length() == 0 || "null".equals(name) || "[null]".equals(name)) {
            dataSource = null;
        } else if (name.trim().length() > 0) {
            dataSource = new ComboPooledDataSource(name);
        } else {
            dataSource = new ComboPooledDataSource();
        }
    }

    // 在静态代码块中创建数据库连接池
    public static DbFactory getInstance(String name) {
        C3P0Factory c3P0Factory = instances.get(name);
        if (c3P0Factory == null) {
            c3P0Factory = new C3P0Factory(name);
            instances.put(name, c3P0Factory);
        }
        return c3P0Factory;
    }

    public String getJdbcUrl() {
        if (dataSource == null) return "";
        return dataSource.getJdbcUrl();
    }

    public String getDriverClass() {
        if (dataSource == null) return "";
        return dataSource.getDriverClass();
    }

    public String getPassword() {
        if (dataSource == null) return "";
        return dataSource.getPassword();
    }

    public String getUser() {
        if (dataSource == null) return "";
        return dataSource.getUser();
    }

    /**
     * 从数据源中获取数据库连接
     */
    public Connection getConnection() throws SQLException {
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

    /**
     * 开启事务
     */
    public void startTransaction() throws SQLException {
        // 开启事务
        getConnection().setAutoCommit(false);
    }

    /**
     * 回滚事务
     */
    public void rollback() throws SQLException {
        // 从当前线程中获取Connection
        Connection conn = threadLocal.get();
        if (conn != null) {
            // 回滚事务
            conn.rollback();
        }
    }

    /**
     * 提交事务
     */
    public void commit() throws SQLException {
        // 从当前线程中获取Connection
        Connection conn = threadLocal.get();
        if (conn != null) {
            // 提交事务
            conn.commit();
        }
    }

    /**
     * 关闭数据库连接(注意，并不是真的关闭，而是把连接还给数据库连接池)
     */
    public void close() throws SQLException {
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
     */
    public DataSource getDataSource() {
        // 从数据源中获取数据库连接
        return dataSource;
    }
}
