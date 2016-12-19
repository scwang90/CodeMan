package com.codesmither.project;

import com.codesmither.project.base.api.DbFactory;
import com.codesmither.project.htmltable.factory.C3P0Factory;
import org.junit.Test;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

/**
 * SqlService
 * Created by SCWANG on 2016/12/15.
 */
public class SqlServerTester {

    public static class TestItem {

        public String Id;
        public String Name;
        public List<OptionItem> Options = new ArrayList<>();

        public static class OptionItem {
            public String Id;
            public String Name;

            @Override
            public String toString() {
                return "OptionItem{" +
                        "Id='" + Id + '\'' +
                        ", Name='" + Name + '\'' +
                        '}';
            }
        }

        @Override
        public String toString() {
            return "TestItem{" +
                    "Id='" + Id + '\'' +
                    ", Name='" + Name + '\'' +
                    ", Options=" + Options +
                    '}';
        }
    }

    public static final String ACTIVITYID = "62140ace-153c-4bea-9b33-b83427d959a0";
    public static final String TEXT =
    "0\n"+
    "检查墙面是否开裂，受潮泛黄，腻子粉脱落或起皮，瓷砖是否空鼓和损坏\n"+
    "开裂，受潮泛黄\n"+
    "腻子粉脱落，起皮\n"+
    "空鼓，损坏\n"+
    "1\n"+
    "检查原顶面是否有受潮泛黄，顶面吊顶是否有开裂或塌陷\n"+
    "受潮泛黄\n"+
    "开裂或塌陷\n"+
    "2\n"+
    "检查地板瓷砖是否有空鼓，松动；地板瓷砖是否有开裂、破损；木地板是否有受潮变形翘拱\n"+
    "空鼓，松动\n"+
    "开裂、破损\n"+
    "受潮，变形，翘拱\n"+
    "3\n"+
    "检查厨房、卫生间下水管道是否有堵塞；厨房、卫生间给水管是否有渗漏；给水管丝头与卫生洁具软管连接处是否有渗漏\n"+
    "下水道管堵塞\n"+
    "给水管渗漏\n"+
    "连接处渗漏\n"+
    "4\n"+
    "检查厨房、卫生间所有洁具是否牢固；所有卫生洁具水龙头是否灵活；所有卫生间水龙头是否水量充足，堵塞\n"+
    "不牢固\n"+
    "不灵活\n"+
    "不充足，堵塞\n"+
    "5\n"+
    "检查电路管线是否匹配有无跳闸，空开是否跳闸，配电箱是否漏电，灯具是否接触不良\n"+
    "电路管线跳闸\n"+
    "空开跳闸\n"+
    "配电箱漏电\n"+
    "灯具接触不良\n"+
    "6\n"+
    "检查所用灯具是否牢固，有无松动现象；灯具光源是否正常，有无闪光现象；灯具灯珠是否损坏以及接触不良现象\n"+
    "灯具松动\n"+
    "光源不正常\n"+
    "灯珠损坏或接触不良\n"+
    "7\n"+
    "用检测仪检测室内空气中是否有超标的有害气体存在\n"+
    "空气超标\n"+
    "8\n"+
    "检查检查门锁是否开关灵活，门缝是否严实；检查门锁是否老化\n"+
    "门锁开关不灵活\n"+
    "门锁老化\n"+
    "9\n"+
    "业主名称\n"+
    "a\n"+
    "业主联系电话\n"+
    "b\n"+
    "业主家庭地址\n";

    @Test
    public void open() throws SQLException {
        String[] options = TEXT.split("\\n");

        List<TestItem> items = new ArrayList<>();
        for (int i = 0; i < options.length; i++) {
            String option = options[i];
            if (option.length() == 1) {
                TestItem item = new TestItem();
                items.add(item);
                item.Id = String.format("01-%03d", items.size());
                item.Name = options[++i];
            } else {
                TestItem item = items.get(items.size() - 1);
                TestItem.OptionItem optionItem = new TestItem.OptionItem();
                item.Options.add(optionItem);
                optionItem.Id = String.format("%s-%03d", item.Id, item.Options.size());
                optionItem.Name = option;
            }
        }

        System.out.println(Arrays.toString(items.toArray()));


        DbFactory instance = C3P0Factory.getInstance("SqlServer-Worker");
        DataSource dataSource = instance.getDataSource();
        Connection connection = dataSource.getConnection();

        for (TestItem item : items) {
            String sql = "insert into worker_TestItem (Id,ActivityId,Name,IsEnable,UserId) values(?,?,?,?,?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, item.Id);
            statement.setString(2, ACTIVITYID);
            statement.setString(3, item.Name);
            statement.setBoolean(4, true);
            statement.setString(5, "1");
            statement.executeUpdate();
            statement.close();
            for (TestItem.OptionItem option : item.Options) {
                sql = "insert into worker_TestItemOption (Id,ItemId,Name,UserId) values(?,?,?,?)";
                statement = connection.prepareStatement(sql);
                statement.setString(1, option.Id);
                statement.setString(2, item.Id);
                statement.setString(3, option.Name);
                statement.setString(4, "1");
                statement.executeUpdate();
                statement.close();
            }
        }
        connection.close();


//        String sql = "insert into students (Name,Sex,Age) values(?,?,?)";
//        PreparedStatement pstmt;
//        try {
//            pstmt = (PreparedStatement) connection.prepareStatement(sql);
//            pstmt.setString(1, student.getName());
//            pstmt.setString(2, student.getSex());
//            pstmt.setString(3, student.getAge());
//            i = pstmt.executeUpdate();
//            pstmt.close();
//            conn.close();
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
    }

}
