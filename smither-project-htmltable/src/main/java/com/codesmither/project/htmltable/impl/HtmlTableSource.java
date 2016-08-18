package com.codesmither.project.htmltable.impl;

import com.codesmither.project.base.api.Converter;
import com.codesmither.project.base.api.Remarker;
import com.codesmither.project.base.api.TableSource;
import com.codesmither.project.base.impl.DbRemarker;
import com.codesmither.project.base.model.Table;
import com.codesmither.project.base.model.TableColumn;
import com.codesmither.project.base.util.StringUtil;
import com.codesmither.project.htmltable.HtmlTableConfig;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.File;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

/**
 * HTML Table 表源
 * Created by SCWANG on 2016/8/1.
 */
public class HtmlTableSource implements TableSource {

    public interface HtmlTableMetaData {
        Elements getTable(Document document) ;
        Elements getTableColumn(Element tableElement);
        Elements getMetaData(Element columnElement);

        int getColumnTypeInt(Elements columnMetaData);
        int getColumnLenght(Elements columnMetaData);
        String getColumnName(Elements columnMetaData);
        String getColumnType(Elements columnMetaData);
        String getColumnDefvalue(Elements columnMetaData);
        String getColumnRemark(Elements columnMetaData);
        boolean getColumnNullable(Elements columnMetaData);
        boolean getColumnAutoIncrement(Elements columnMetaData);
    }

    protected HashMap<String, Integer> DbTypeMap = new HashMap<String, Integer>() {
        {
            put("bit", Types.BIT);
            put("real", Types.REAL);
            put("datetime", Types.DATE);
            put("int", Types.INTEGER);
            put("bigint", Types.BIGINT);
            put("varchar", Types.VARCHAR);
            put("nvarchar", Types.NVARCHAR);
            put("varbinary", Types.VARBINARY);
        }
    };

    protected Converter converter;
    protected String charset = "UTF-8";
    protected List<File> htmlfiles = new ArrayList<>();
    protected Remarker remarker = new DbRemarker();
    protected HtmlTableMetaData metaData = new HtmlTableMetaDataImpl();

    public HtmlTableSource(HtmlTableConfig config) {
        this.converter = config.getConverter();
        this.charset = config.getHtmlTableCharset();
        File file = new File(config.getHtmlTablePath());
        if (file.isDirectory()) {
            htmlfiles = new ArrayList<>();
            File[] files = file.listFiles();
            if (files != null) {
                for (File html : files) {
                    if (!html.isDirectory() && html.getName().toLowerCase().endsWith(".html") && html.length() < 512*1024) {
                        htmlfiles.add(html);
                    }
                }
            }
        } else {
            htmlfiles = Collections.singletonList(file);
        }
    }

    @Override
    public List<Table> build() throws Exception {
        List<Document> documents = new ArrayList<>();
        for (File file : htmlfiles) {
            documents.add(Jsoup.parse(file, charset));
        }
        Elements tableElements = new Elements();
        for (Document document : documents) {
            tableElements.addAll(metaData.getTable(document));
        }
        List<Table> tables = new ArrayList<>();
        for (Element tableElement : tableElements) {
            tables.add(buildTable(tableElement));
        }
        return tables;
    }

    protected Table buildTable(Element tableElement) {
        Table table = new Table();
        buildTableMetaData(tableElement, table);
        table.setClassName(this.converter.converterClassName(table.getName()));
        table.setClassNameCamel(StringUtil.lowerFirst(table.getClassName()));
        table.setClassNameUpper(table.getClassName().toUpperCase());
        table.setClassNameLower(table.getClassName().toLowerCase());
        if (table.getRemark() == null || table.getRemark().trim().length()==0) {
            table.setRemark(remarker.getTableRemark(table.getName()));
        }
        Elements columnElements = metaData.getTableColumn(tableElement);
        List<TableColumn> columnList = new ArrayList<>();
        for (Element columnElement : columnElements) {
            columnList.add(buildColumn(columnElement));
        }
        table.setColumns(columnList);
        buildTableIdColumn(table);
        return table;
    }

    protected TableColumn buildColumn(Element columnElement) {
        TableColumn column = new TableColumn();
        Elements columnMetaData = metaData.getMetaData(columnElement);
        buildColumnMetaData(column, columnMetaData);

        column.setFieldName(this.converter.converterFieldName(column.getName()));
        column.setFieldType(this.converter.converterFieldType(column.getTypeInt()));
        column.setFieldNameUpper(StringUtil.upperFirst(column.getFieldName()));
        column.setFieldNameLower(StringUtil.lowerFirst(column.getFieldName()));

        if (column.getRemark() == null || column.getRemark().trim().length()==0) {
            column.setRemark(remarker.getColumnRemark(column.getName()));
        }
        return column;
    }

    /**
     * 默认选择第一行为ID
     */
    protected void buildTableIdColumn(Table table) {
        if (table.getColumns() != null && table.getColumns().size() > 0) {
            table.setIdColumn(table.getColumns().get(0));
        }
    }

    protected void buildTableMetaData(Element tableElement, Table table) {
        Element element = tableElement.previousElementSibling().clone();
        table.setRemark(element.text());
        table.setName(element.select("span").text());
    }

    protected void buildColumnMetaData(TableColumn column, Elements columnMetaData) {
        column.setName      (metaData.getColumnName    (columnMetaData));
        column.setType      (metaData.getColumnType    (columnMetaData));
        column.setTypeInt   (metaData.getColumnTypeInt (columnMetaData));
        column.setLenght    (metaData.getColumnLenght  (columnMetaData));
        column.setDefvalue  (metaData.getColumnDefvalue(columnMetaData));
        column.setNullable  (metaData.getColumnNullable(columnMetaData));
        column.setRemark    (metaData.getColumnRemark  (columnMetaData));
        column.setAutoIncrement(metaData.getColumnAutoIncrement(columnMetaData));
    }

    protected class HtmlTableMetaDataImpl implements HtmlTableMetaData {
        public Elements getTable(Document document) {
            return document.select("table");
        }
        public Elements getTableColumn(Element tableElement) {
            Elements tr = tableElement.select("tr");
            if (tr.size() > 0) {
                tr.remove(0);
            }
            return tr;
        }
        public Elements getMetaData(Element columnElement) {
            return columnElement.select("td");
        }

        @Override
        public int getColumnTypeInt(Elements columnMetaData) {
            String type = getColumnType(columnMetaData);
            if (type != null && DbTypeMap.containsKey(type)) {
                return DbTypeMap.get(type);
            }
            return 0;
        }

        @Override
        public int getColumnLenght(Elements columnMetaData) {
            if (columnMetaData.size() > 2) {
                return Integer.parseInt(columnMetaData.get(2).text().replace(",",""));
            }
            return 0;
        }

        @Override
        public String getColumnName(Elements columnMetaData) {
            if (columnMetaData.size() > 0) {
                return columnMetaData.get(0).text().replace(" ","");
            }
            return "";
        }

        @Override
        public String getColumnType(Elements columnMetaData) {
            if (columnMetaData.size() > 1) {
                return columnMetaData.get(1).text();
            }
            return "";
        }

        @Override
        public String getColumnDefvalue(Elements columnMetaData) {
            if (columnMetaData.size() > 3) {
                return columnMetaData.get(3).text();
            }
            return "";
        }

        @Override
        public String getColumnRemark(Elements columnMetaData) {
            if (columnMetaData.size() > 6) {
                return columnMetaData.get(6).text();
            }
            return "";
        }

        @Override
        public boolean getColumnNullable(Elements columnMetaData) {
            if (columnMetaData.size() > 4) {
                return "允许".equals(columnMetaData.get(4).text());
            }
            return false;
        }

        @Override
        public boolean getColumnAutoIncrement(Elements columnMetaData) {
            if (columnMetaData.size() > 5) {
                return "自增".equals(columnMetaData.get(5).text());
            }
            return false;
        }

    }
}
