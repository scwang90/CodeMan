package com.code.smither.project.database.impl;

import com.code.smither.project.base.api.*;
import com.code.smither.project.base.constant.Database;
import com.code.smither.project.base.model.ForeignKey;
import com.code.smither.project.base.model.IndexedKey;
import com.code.smither.project.base.model.Table;
import com.code.smither.project.base.model.TableColumn;
import com.code.smither.project.htmltable.HtmlTableConfig;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.File;
import java.sql.Types;
import java.util.*;

/**
 * HTML Table 表源
 * Created by SCWANG on 2016/8/1.
 */
@SuppressWarnings("WeakerAccess")
public class HtmlTableSource implements TableSource {

    public interface HtmlTableMetaData {
        Elements getTables(Document document) ;
        Elements getTableColumns(Element tableElement);
        Elements getColumnMetaData(Element columnElement);

        String getTableName(Element tableElement);
        String getTableRemark(Element tableElement);

        int getColumnTypeInt(Elements columnMetaData);
        int getColumnLength(Elements columnMetaData);
        String getColumnName(Elements columnMetaData);
        String getColumnType(Elements columnMetaData);
        String getColumnDefValue(Elements columnMetaData);
        String getColumnRemark(Elements columnMetaData);
        boolean getColumnNullable(Elements columnMetaData);
        boolean getColumnAutoIncrement(Elements columnMetaData);
        boolean getColumnPrimaryKey(Elements columnMetaData);
    }

    protected HashMap<String, Integer> DbTypeMap = new HashMap<String, Integer>() {
        {
            //mysql
            put("bit", Types.BIT);
            put("real", Types.REAL);
            put("datetime", Types.DATE);
            put("int", Types.INTEGER);
            put("bigint", Types.BIGINT);
            put("varchar", Types.VARCHAR);
            put("nvarchar", Types.NVARCHAR);
            put("varbinary", Types.VARBINARY);
            //oracle
            put("BFILE",Types.BINARY);
            put("BINARY_DOUBLE",Types.BINARY);
            put("BINARY_FLOAT",Types.BINARY);
            put("BLOB",Types.BLOB);
            put("CHAR",Types.CHAR);
            put("CHAR VARYING",Types.VARCHAR);
            put("CHARACTER",Types.CHAR);
            put("CHARACTER VARYING",Types.VARCHAR);
            put("CLOB",Types.CLOB);
            put("DATE",Types.DATE);
            put("DECIMAL",Types.DECIMAL);
            put("DOUBLE PRECISION",Types.DOUBLE);
            put("FLOAT",Types.FLOAT);
            put("INT",Types.INTEGER);
            put("INTEGER",Types.INTEGER);
            put("INTERVAL DAY TO SECOND",Types.BIGINT);
            put("INTERVAL YEAR TO MONTH",Types.BIGINT);
            put("LONG",Types.BIGINT);
            put("LONG RAW",Types.BIGINT);
            put("LONG VARCHAR",Types.BIGINT);
            put("NATIONAL CHAR",Types.CHAR);
            put("NATIONAL CHAR VARYING",Types.CHAR);
            put("NATIONAL CHARACTER",Types.CHAR);
            put("NATIONAL CHARACTER VARYING",Types.CHAR);
            put("NCHAR",Types.NCHAR);
            put("NCHAR VARYING",Types.NVARCHAR);
            put("NCLOB",Types.NCLOB);
            put("NUMBER",Types.DOUBLE);
            put("NUMERIC",Types.NUMERIC);
            put("NVARCHAR2",Types.NVARCHAR);
            put("RAW",Types.BINARY);
            put("REAL",Types.REAL);
            put("ROWID",Types.BIGINT);
            put("SMALLINT",Types.SMALLINT);
            put("TIMESTAMP",Types.TIMESTAMP);
            put("TIMESTAMP WITH LOCAL TIME ZONE",Types.TIMESTAMP_WITH_TIMEZONE);
            put("TIMESTAMP WITH TIME ZONE",Types.TIMESTAMP_WITH_TIMEZONE);
            put("UROWID",Types.BIGINT);
            put("VARCHAR",Types.VARCHAR);
            put("VARCHAR2",Types.VARCHAR);
        }
    };

    protected String charset;
//    protected ClassConverter classConverter;
//    protected Remarker remarker = new DbRemarker();
    protected List<File> htmlFiles;
    protected HtmlTableMetaData metaData = new HtmlTableMetaDataImpl();

    public HtmlTableSource(HtmlTableConfig config) {
//        this.classConverter = config.getClassConverter();
        this.charset = config.getHtmlTableCharset();
        File file = new File(config.getHtmlTablePath());
        if (file.isDirectory()) {
            htmlFiles = new ArrayList<>();
            File[] files = file.listFiles();
            if (files != null) {
                for (File html : files) {
                    if (!html.isDirectory() && html.getName().toLowerCase().endsWith(".html") && html.length() < 512*1024) {
                        htmlFiles.add(html);
                    }
                }
            }
        } else {
            htmlFiles = Collections.singletonList(file);
        }
    }

    @Override
    public Database getDatabase() {
        return null;
    }

    @Override
    public Table buildTable(MetaDataTable tableMate) {
        if (tableMate instanceof TableMetaData) {
            return buildTableMetaData(((TableMetaData) tableMate).element);
        }
        return null;
    }

    @Override
    public TableColumn buildColumn(MetaDataColumn columnMate) {
        if (columnMate instanceof ColumnMetaData) {
            return buildColumnMetaData(((ColumnMetaData) columnMate).columnMetaData);
        }
        return null;
    }

    @Override
    public IndexedKey buildIndexedKey(MetaDataIndex index) {
        return null;
    }

    @Override
    public ForeignKey buildForeignKey(MetaDataForegin foregin) {
        return null;
    }

    @Override
    public List<? extends MetaDataTable> queryTables() throws Exception {
        List<Document> documents = new ArrayList<>();
        for (File file : htmlFiles) {
            documents.add(Jsoup.parse(file, charset));
        }
        Elements tableElements = new Elements();
        for (Document document : documents) {
            tableElements.addAll(metaData.getTables(document));
        }
        List<TableMetaData> tables = new ArrayList<>();
        for (Element tableElement : tableElements) {
            tables.add(new TableMetaData(tableElement));
        }
        return tables;
    }

    @Override
    public List<? extends MetaDataColumn> queryColumns(MetaDataTable tableMate) {
        List<ColumnMetaData> columnList = new ArrayList<>();
        if (tableMate instanceof TableMetaData) {
            TableMetaData table = ((TableMetaData) tableMate);
            Elements columnElements = metaData.getTableColumns(table.element);
            for (Element columnElement : columnElements) {
                columnList.add(new ColumnMetaData(columnElement));
            }
        }
        return columnList;
    }

    @Override
    public Set<String> queryPrimaryKeys(MetaDataTable tableMate) {
        Set<String> keys = new LinkedHashSet<>();
        if (tableMate instanceof TableMetaData) {
            TableMetaData table = ((TableMetaData) tableMate);
            Elements columns = metaData.getTableColumns(table.element);
            for (Element column : columns) {
                Elements meta = metaData.getColumnMetaData(column);
                if (metaData.getColumnPrimaryKey(meta)) {
                    keys.add(metaData.getColumnName(meta));
                }
            }
        }
        return keys;
    }

    @Override
    public List<? extends MetaDataIndex> queryIndexKeys(MetaDataTable table) throws Exception {
        return Collections.emptyList();
    }

    @Override
    public List<? extends MetaDataForegin> queryImportedKeys(MetaDataTable table) throws Exception {
        return Collections.emptyList();
    }

    @Override
    public List<? extends MetaDataForegin> queryExportedKeys(MetaDataTable table) throws Exception {
        return Collections.emptyList();
    }

    @Override
    public String queryColumnRemark(MetaDataColumn columnMate) {
        return null;
    }

    @Override
    public String queryTableRemark(MetaDataTable tableMate) {
        return null;
    }

    protected Table buildTableMetaData(Element tableElement) {
        Table table = new Table();
        table.setName(metaData.getTableName(tableElement));
        table.setRemark(metaData.getTableRemark(tableElement));
        table.setComment(metaData.getTableRemark(tableElement));
        return table;
    }

    protected TableColumn buildColumnMetaData(Elements columnMetaData) {
        TableColumn column = new TableColumn();
        column.setName      (metaData.getColumnName    (columnMetaData));
        column.setType      (metaData.getColumnType    (columnMetaData));
        column.setTypeInt   (metaData.getColumnTypeInt (columnMetaData));
        column.setLength    (metaData.getColumnLength  (columnMetaData));
        column.setDefValue  (metaData.getColumnDefValue(columnMetaData));
        column.setNullable  (metaData.getColumnNullable(columnMetaData));
        column.setRemark    (metaData.getColumnRemark  (columnMetaData));
        column.setComment   (metaData.getColumnRemark  (columnMetaData));
        column.setAutoIncrement(metaData.getColumnAutoIncrement(columnMetaData));
        return column;
    }

    protected class TableMetaData implements MetaDataTable {

        public final Element element;

        public TableMetaData(Element element) {
            this.element = element;
        }

        @Override
        public String getName() {
            return metaData.getTableName(element);
        }

        @Override
        public void setName(String string) {
        }

        @Override
        public void setComment(String string) {
        }
    }

    protected class ColumnMetaData extends TableMetaData implements MetaDataColumn {

        public final Elements columnMetaData;

        public ColumnMetaData(Element element) {
            super(element);
            columnMetaData = metaData.getColumnMetaData(element);
        }

        @Override
        public String getName() {
            return metaData.getColumnName(columnMetaData);
        }

        @Override
        public void setType(String string) {
        }

        @Override
        public void setTypeInt(int int1) {
        }

        @Override
        public void setLength(int int1) {
        }

        @Override
        public void setDefValue(String string) {
        }

        @Override
        public void setNullable(boolean boolean1) {
        }

        @Override
        public void setRemark(String string) {
        }

        @Override
        public void setDecimalDigits(int int1) {
        }

        @Override
        public void setAutoIncrement(boolean b) {
        }
    }

    protected class HtmlTableMetaDataImpl implements HtmlTableMetaData {

        public Elements getTables(Document document) {
            return document.select("table");
        }

        public Elements getTableColumns(Element tableElement) {
            Elements tr = tableElement.select("tr");
            if (tr.size() > 0) {
                tr.remove(0);
            }
            return tr;
        }

        public Elements getColumnMetaData(Element columnElement) {
            return columnElement.select("td");
        }

        @Override
        public String getTableName(Element tableElement) {
            return tableElement.attr("name");
        }

        @Override
        public String getTableRemark(Element tableElement) {
            return tableElement.attr("remark");
        }

        @Override
        public int getColumnTypeInt(Elements columnMetaData) {
            String type = getColumnType(columnMetaData);
            if (type != null) {
                type = type.replaceAll("\\(.*?\\)", "");
            }
            if (type != null && DbTypeMap.containsKey(type)) {
                return DbTypeMap.get(type);
            }
            return 0;
        }

        @Override
        public int getColumnLength(Elements columnMetaData) {
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
        public String getColumnDefValue(Elements columnMetaData) {
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
                return !"是".equals(columnMetaData.get(4).text());
            }
            return false;
        }

        @Override
        public boolean getColumnAutoIncrement(Elements columnMetaData) {
            if (columnMetaData.size() > 5) {
                return columnMetaData.get(5).text().contains("自增");
            }
            return false;
        }

        @Override
        public boolean getColumnPrimaryKey(Elements columnMetaData) {
            if (columnMetaData.size() > 5) {
                return columnMetaData.get(5).text().startsWith("是");
            }
            return false;
        }

    }
}
