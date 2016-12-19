package com.generator.yxtech.app$house.excel2db.kernel;

import com.generator.database.c3p0.C3P0Factory;
import com.generator.yxtech.app$house.excel2db.api.ModelBuilder;
import com.generator.yxtech.app$house.excel2db.model.Service;
import com.generator.yxtech.app$house.excel2db.reader.ExcelReader;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

/**
 * 引擎
 * Created by SCWANG on 2016/12/19.
 */
public class ExcelEngine {

    public static final String TABLENAME = "worker_Profession";

    public class Clear {
        public void clear() throws SQLException {
            C3P0Factory instance = C3P0Factory.getInstance(mDbInstance);
            try (Connection connection = instance.getConnection()){
                String sql = String.format("DELETE from %s WHERE Id LIKE '%s-%%'", TABLENAME, mRootId);
                try (PreparedStatement statement = connection.prepareStatement(sql)){
                    statement.executeUpdate();
                }
            }
        }
    }

    protected String mRootId;
    protected String mExcelPath;
    protected String mDbInstance;
    protected ModelBuilder mBuilder;

    public ExcelEngine(String rootId, String excelpath, String dbInstance, ModelBuilder builder) {
        this.mRootId = rootId;
        this.mBuilder = builder;
        this.mExcelPath = excelpath;
        this.mDbInstance = dbInstance;
    }

    public void clear() throws SQLException {
        new Clear().clear();
    }

    public void driver() throws SQLException {
        ExcelReader reader = new ExcelReader(mExcelPath);

        List<Service> services = mBuilder.build(reader.loadData());
        System.out.println(Arrays.toString(services.toArray()));

        C3P0Factory instance = C3P0Factory.getInstance(mDbInstance);
        try (Connection connection = instance.getConnection()){
            for (int i = 0; i < services.size(); i++) {
                Service service = services.get(i);
                String sql = "insert into worker_Profession (Id,ParentId,Name,Description,Ended) values(?,?,?,?,?)";
                try (PreparedStatement stservice = connection.prepareStatement(sql)){
                    stservice.setString(1, String.format("%s-%03d", mRootId, (i + 1)));
                    stservice.setString(2, mRootId);
                    stservice.setString(3, service.Name);
                    stservice.setString(4, null);
                    stservice.setString(5, "1");
                    stservice.executeUpdate();
                    for (int j = 0; j < service.Items.size(); j++) {
                        Service.Item item = service.Items.get(j);
                        try (PreparedStatement stitem = connection.prepareStatement(sql)){
                            stitem.setString(1, String.format("%s-%03d-%03d", mRootId, (i + 1), (j + 1)));
                            stitem.setString(2, String.format("%s-%03d", mRootId, (i + 1)));
                            stitem.setString(3, item.Name);
                            stitem.setString(4, item.Remark);
                            stitem.setString(5, "1");
                            stitem.executeUpdate();
                        }
                    }
                }

            }
        }
    }

}
