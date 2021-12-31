package com.code.smither.project.database.factory;

import com.code.smither.project.database.api.DbFactory;
import com.mchange.v2.c3p0.ComboPooledDataSource;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;

/**
 * C3p0数据库链接池
 * Created by SCWANG on 2015-07-04.
 */
public class C3P0Factory implements DbFactory {

    private static final HashMap<String, C3P0Factory> instances = new HashMap<>();

    private ComboPooledDataSource dataSource = null;
    // 使用ThreadLocal存储当前线程中的Connection对象
    private final ThreadLocal<Connection> threadLocal = new ThreadLocal<>();

    protected C3P0Factory(String name) {
        if (name == null || name.trim().length() == 0 || "null".equals(name) || "[null]".equals(name)) {
            dataSource = null;
        } else {
            dataSource = new ComboPooledDataSource(name);
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

    @Override
    public String getJdbcUrl() {
        if (dataSource == null) return "";
        return dataSource.getJdbcUrl();
    }

    @Override
    public String getDriver() {
        if (dataSource == null) return "";
        return dataSource.getDriverClass();
    }

    @Override
    public String getPassword() {
        if (dataSource == null) return "";
        return dataSource.getPassword();
    }

    @Override
    public String getUsername() {
        if (dataSource == null) return "";
        return dataSource.getUser();
    }

    /**
     * 从数据源中获取数据库连接
     */
    @Override
    public Connection getConnection() throws SQLException {
        // 从当前线程中获取Connection
        Connection conn = threadLocal.get();
        if (conn == null && dataSource != null) {
            // 从数据源中获取数据库连接
            conn = dataSource.getConnection();
            // 将conn绑定到当前线程
            threadLocal.set(conn);
        }
        return conn;
    }
}
