package com.codesmither.factory;

import java.sql.Connection;
import java.sql.SQLException;

import javax.sql.DataSource;

import com.mchange.v2.c3p0.ComboPooledDataSource;

/**
 * @ClassName: JdbcUtils2
 * @Description: 数据库连接工具类
 * @author: 孤傲苍狼
 * @date: 2014-10-4 下午6:04:36
 *
 */
public class C3P0Factory {

	private static ComboPooledDataSource dataSource = null;
	// 使用ThreadLocal存储当前线程中的Connection对象
	private static ThreadLocal<Connection> threadLocal = new ThreadLocal<Connection>();

	// 在静态代码块中创建数据库连接池
	static {
		String name = ConfigFactory.getDbConfigName();
		if (name != null && name.trim().length() > 0) {
			dataSource = new ComboPooledDataSource(name);
		}else {
			dataSource = new ComboPooledDataSource();
		}
	}
	
	

	/**
	 * @Method: getConnection
	 * @Description: 从数据源中获取数据库连接
	 * @Anthor:孤傲苍狼
	 * @return Connection
	 * @throws SQLException
	 */
	public static Connection getConnection() throws SQLException {
		// 从当前线程中获取Connection
		Connection conn = threadLocal.get();
		if (conn == null) {
			// 从数据源中获取数据库连接
			conn = getDataSource().getConnection();
			// 将conn绑定到当前线程
			threadLocal.set(conn);
		}
		return conn;
	}

	public static String getJdbcUrl() {
		return dataSource.getJdbcUrl();
	}

	public static String getDriverClass() {
		return dataSource.getDriverClass();
	}

	public static String getPassword() {
		return dataSource.getPassword();
	}

	public static String getUser() {
		return dataSource.getUser();
	}

	/**
	 * @throws SQLException
	 * @Method: startTransaction
	 * @Description: 开启事务
	 * @Anthor:孤傲苍狼
	 */
	public static void startTransaction() throws SQLException {
		// 开启事务
		getConnection().setAutoCommit(false);
	}

	/**
	 * @throws SQLException
	 * @Method: rollback
	 * @Description:回滚事务
	 * @Anthor:孤傲苍狼
	 *
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
	 * @throws SQLException
	 * @Method: commit
	 * @Description:提交事务
	 * @Anthor:孤傲苍狼
	 *
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
	 * @throws SQLException 
	 * @Method: close
	 * @Description:关闭数据库连接(注意，并不是真的关闭，而是把连接还给数据库连接池)
	 * @Anthor:孤傲苍狼
	 *
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
	 * @Method: getDataSource
	 * @Description: 获取数据源
	 * @Anthor:孤傲苍狼
	 * @return DataSource
	 */
	public static DataSource getDataSource() {
		// 从数据源中获取数据库连接
		return dataSource;
	}
}
