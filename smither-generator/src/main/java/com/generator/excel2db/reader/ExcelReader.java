package com.generator.yxtech.app$house.excel2db.reader;

import com.generator.yxtech.app$house.excel2db.model.Service;
import org.apache.poi.ss.usermodel.*;

import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

/**
 * Created by SCWANG on 2016/12/19.
 */
public class ExcelReader {

    protected String mExcelPath;

    protected List<List<String>> mData;

    public ExcelReader(String path) {
        this.mExcelPath = path;
        this.mData = loadData();
    }

    public List<List<String>> loadData() {
        List<List<String>> data = new ArrayList<>();
        try (InputStream in = new FileInputStream(mExcelPath)) {
            Workbook workbook = WorkbookFactory.create(in);
            // 获得第一个工作表对象
            Sheet sheet = workbook.getSheetAt(0);
            // 得到第一列第一行的单元格
            Iterator<Row> rowIterator = sheet.rowIterator();
            while (rowIterator.hasNext()) {
                List<String> rowList = new ArrayList<>();
                Row row = rowIterator.next();
                Iterator<Cell> cellIterator = row.cellIterator();
                while (cellIterator.hasNext()) {
                    Cell cell = cellIterator.next();
                    rowList.add(cell.toString());
                }
                data.add(rowList);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return data;
    }


//    public List<Service> toService(int startrow, int starcolumn) {
//        List<Service> services = new ArrayList<>();
//        for (List<String> row : mData.subList(startrow,mData.size() - startrow)) {
//            row = row.subList(starcolumn, row.size() - starcolumn);
//            Service service = new Service();
//            service.Name = row.get(0);
//            service.Items = new ArrayList<>();
//            for (final String item : row.get(1).replaceFirst("\\s*\\d\\.", "").split("\\s*\\d\\.")) {
//                service.Items.add(new Service.Item(){{
//                    this.Name = item;
//                    this.Remark = "";
//                }});
//            }
//            services.add(service);
//            System.out.println(row.get(1));
//        }
//        return services;
//    }
}
