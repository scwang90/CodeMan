package com.generator.excel2db;

import com.generator.excel2db.api.ModelBuilder;
import com.generator.excel2db.kernel.ExcelEngine;
import com.generator.excel2db.model.Service;
import org.junit.Test;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;


/**
 * Created by SCWANG on 2016/12/19.
 */
public class ExcelEngineTester {

    @Test
    public void path() {
        System.out.println(new File("").getAbsoluteFile());
    }

    @Test
    public void demo_clear() throws Exception {
        String ROOT_ID = "020";
        String excelpath = "src\\main\\resources\\demo-excel2db.xls";
        ExcelEngine engine = new ExcelEngine(ROOT_ID, excelpath, "SqlServer-Worker", null);
        engine.clear();
    }

    @Test
    public void demo_generator() throws Exception {
        String ROOT_ID = "020";
        String excelpath = "src\\main\\resources\\demo-excel2db.xls";
        ExcelEngine engine = new ExcelEngine(ROOT_ID, excelpath, "SqlServer-Worker", new ModelBuilder() {
            @Override
            public List<Service> build(List<List<String>> rows) {
                int startRow = 3, startColumn = 1;
                String lastName = "";
                LinkedHashMap<String, Service> mapService = new LinkedHashMap<>();

                for (List<String> row : rows) {
                    System.out.println(Arrays.asList(row.toArray()));
                }

                for (List<String> row : rows.subList(startRow, rows.size() - 1)) {
                    row = row.subList(startColumn, row.size() - startColumn + 1);

                    String thisname = row.get(0);
                    if (thisname.trim().length() == 0) {
                        thisname = lastName;
                    }

                    Service service = mapService.get(thisname);
                    if (service == null) {
                        service = new Service();
                        service.Name = thisname;
                        service.Items = new ArrayList<>();
                        mapService.put(lastName = thisname, service);
                    }

                    service.Items.add(new Service.Item(row.get(1), row.get(2)));
                    System.out.println(row.get(1));
                }
                return new ArrayList<>(mapService.values());
            }
        });
        engine.driver();
    }

}