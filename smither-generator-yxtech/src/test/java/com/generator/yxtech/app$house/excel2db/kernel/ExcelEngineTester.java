package com.generator.yxtech.app$house.excel2db.kernel;

import com.generator.yxtech.app$house.excel2db.api.ModelBuilder;
import com.generator.yxtech.app$house.excel2db.model.Service;
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
    public void maintain_clear() throws Exception {
        String ROOT_ID = "020";
        String excelpath = "src\\main\\resources\\APP维修表.xls";
        ExcelEngine engine = new ExcelEngine(ROOT_ID, excelpath, "SqlServer-Worker", null);
        engine.clear();
    }

    @Test
    public void maintain_generator() throws Exception {
        String ROOT_ID = "020";
        String excelpath = "src\\main\\resources\\APP维修表.xls";
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

    @Test
    public void maintain_generator2() throws Exception {
        String ROOT_ID = "020";
        String excelpath = "src\\main\\resources\\房屋维修报价.xls";
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

                    String[] items = row.get(1).replaceAll("。|、","").split("\\s*\\d");
                    for (String item : items) {
                        if (item.trim().length() > 0) {
                            service.Items.add(new Service.Item(item, row.get(2)));
                            System.out.println(item + "--------" + row.get(2));
                        }
                    }

                }
                return new ArrayList<>(mapService.values());//
            }
        });
        engine.driver();
    }

    @Test
    public void homemaking_clear() throws Exception {

        String ROOT_ID = "030";
        String excelpath = "src\\main\\resources\\马上来家装服务报价单.xls";
        ExcelEngine engine = new ExcelEngine(ROOT_ID, excelpath, "SqlServer-Worker", null);
        engine.clear();

    }

    @Test
    public void homemaking_generator() throws Exception {
        String ROOT_ID = "030";
        String excelpath = "src\\main\\resources\\马上来家装服务报价单.xls";
        ExcelEngine engine = new ExcelEngine(ROOT_ID, excelpath, "SqlServer-Worker", new ModelBuilder() {
            @Override
            public List<Service> build(List<List<String>> rows) {
                int startRow = 2, startColumn = 1;
                List<Service> services = new ArrayList<>();
                for (List<String> row : rows.subList(startRow, rows.size() - startRow + 1)) {
                    row = row.subList(startColumn, row.size() - startColumn + 1);
                    Service service = new Service();
                    service.Name = row.get(0);
                    service.Items = new ArrayList<>();
                    for (final String item : row.get(1).replaceFirst("\\s*\\d\\.", "").split("\\s*\\d\\.")) {
                        service.Items.add(new Service.Item(item,String.format("%s元/%s", row.get(3), row.get(2))));
                    }
                    services.add(service);
                    System.out.println(row.get(1));
                }
                return services;
            }
        });
        engine.driver();
    }
}