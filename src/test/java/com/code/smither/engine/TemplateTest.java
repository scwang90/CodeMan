package com.code.smither.engine;

import org.junit.Test;

import java.sql.*;

import static org.jooq.meta.mysql.information_schema.Tables.TABLES;


/**
 * TemplateTest
 * Created by Administrator on 2015/9/16.
 */
public class TemplateTest {

    @Test
    public void testHashCode() {
        System.out.println("\"\".hashCode() = " + "".hashCode());
        System.out.println("\"\".hashCode() = " + "".hashCode());
        System.out.println("new Object().hashCode()) = " + new Object().toString());
        System.out.println("new Object().hashCode()) = " + new Object().hashCode());
    }

    /**
     * 请到 smither-project-database\src\test\java\com\codesmither\project\TemplateTest.java
     * 中运行测试
     */
    @Test
    public void Template() {
        String jdbcUrl = "jdbc:mysql://127.0.0.1:3306";
        String jdbcUsername = "root";
        String jdbcPassword = "123456";

        // 获取 JDBC 链接
        try (Connection connection = DriverManager.getConnection(jdbcUrl, jdbcUsername, jdbcPassword)) {

//            try (Statement stmt = connection.createStatement()) {
//                try (ResultSet rs = stmt.executeQuery("SELECT TABLE_SCHEMA, TABLE_NAME, TABLE_COMMENT FROM information_schema.TABLES WHERE TABLE_SCHEMA='traveler'")) {
//                    while (rs.next()) {
//                        String id = rs.getString(1); // 注意：索引从1开始
//                        String grade = rs.getString(2);
//                        String name = rs.getString(3);
//                        System.out.println("1:" + id + ", 2:" + grade + ", 3:" + name);
//                    }
//                }
//            }
            try (PreparedStatement ps = connection.prepareStatement("SELECT TABLE_SCHEMA, TABLE_NAME, TABLE_COMMENT FROM information_schema.TABLES WHERE TABLE_SCHEMA=?")) {
                ps.setObject(1, "traveler");
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        String id = rs.getString(1); // 注意：索引从1开始
                        String grade = rs.getString(2);
                        String name = rs.getString(3);
                        System.out.println("1:" + id + ", 2:" + grade + ", 3:" + name);
                    }
                }
            }

//            connection.
//            String sql = connection.nativeSQL("SELECT TABLE_SCHEMA, TABLE_NAME, TABLE_COMMENT FROM TABLES WHERE TABLE_SCHEMA='traveler'");
//            System.out.println("sql = " + sql);
            // 获取 jOOQ 执行器
//            DSLContext dslContext = DSL.using(connection, SQLDialect.MYSQL);
//
//            Result<Record3<String, String, String>> fetch = dslContext.select(TABLES.TABLE_SCHEMA,
//                    TABLES.TABLE_NAME,
//                    TABLES.TABLE_COMMENT).from(TABLES).where(TABLES.TABLE_SCHEMA.eq("traveler"))
//                    .fetch();
//
//            System.out.println("result: \n" + fetch.toString());
//            // fetch方法可以返回一个结果集对象 Result
//            // jOOQ的Result对象实现了List接口，可以直接当做集合使用
//            Result<Record> recordResult = dslContext.select().from(USER).fetch();
//            recordResult.forEach(record -> {
//                Integer id = record.getValue(USER.ID);
//                String username = record.getValue(USER.ACCOUNT);
//                System.out.println("fetch Record     id: " + id + " , username: " + username);
//            });
//
//            // 通过 Record.into 方法可以将默认Record对象，转换为表的Record对象，例如S1UserRecord
//            // Result 接口也定义了into方法，可以将整个结果集转换为指定表Record的结果集
//            // 通过 S1UserRecord 可以通过get方法直接获得表对象
//            // 所有表的XXXRecord对象都是实现了 Record 对象的子类
//            Result<UserRecord> userRecordResult = recordResult.into(USER);
//            userRecordResult.forEach(record -> {
//                Integer id = record.getId();
//                String username = record.getAccount();
//                System.out.println("into UserRecord   id: " + id + " , username: " + username);
//            });
//
//            // fetchInto方法可以可以传入任意class类型，或者表常量
//            // 会直接返回任意class类型的List集合，或者指定表Record的结果集对象
//            List<UserRecord> fetchIntoClassResultList = dslContext.select().from(USER).fetchInto(UserRecord.class);
//            Result<UserRecord> fetchIntoTableResultList = dslContext.select().from(USER).fetchInto(USER);
//
//            System.out.println("fetchIntoClassResultList: \n" + fetchIntoClassResultList.toString());
//            System.out.println("fetchIntoTableResultList: \n" + fetchIntoTableResultList.toString());

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
