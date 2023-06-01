package com.code.smither.project.database.impl;

import com.code.smither.project.base.api.*;
import com.code.smither.project.base.constant.Database;
import com.code.smither.project.base.model.ForeignKey;
import com.code.smither.project.base.model.IndexedKey;
import com.code.smither.project.base.model.Table;
import com.code.smither.project.base.model.TableColumn;
import com.code.smither.project.base.util.StringUtil;
import com.code.smither.project.htmltable.HtmlTableConfig;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.File;
import java.sql.Types;
import java.util.*;
import java.util.stream.Collectors;

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
        String getTableSchema(Element tableElement);
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

    protected HashMap<String, Integer> DbTypeMap = new HashMap<>() {
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
            put("text",Types.LONGVARCHAR);

            put("BIT", Types.BIT);
//            put("REAL", Types.REAL);
            put("DATETIME", Types.DATE);
//            put("INT", Types.INTEGER);
            put("BIGINT", Types.BIGINT);
//            put("VARCHAR", Types.VARCHAR);
            put("NVARCHAR", Types.NVARCHAR);
            put("VARBINARY", Types.VARBINARY);
//            put("TEXT",Types.LONGVARCHAR);

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
            put("TEXT",Types.LONGVARCHAR);
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

//    @Override
//    public Table buildTable(MetaDataTable tableMate) {
//        if (tableMate instanceof TableMetaData) {
//            return buildTableMetaData(((TableMetaData) tableMate).element);
//        }
//        return null;
//    }
//
//    @Override
//    public TableColumn buildColumn(MetaDataColumn columnMate) {
//        if (columnMate instanceof ColumnMetaData) {
//            return buildColumnMetaData(((ColumnMetaData) columnMate).columnMetaData);
//        }
//        return null;
//    }


    @Override
    public List<? extends Table> queryTables() throws Exception {
        List<Document> documents = new ArrayList<>();
        for (File file : htmlFiles) {
            documents.add(Jsoup.parse(file, charset));
        }
        Elements tableElements = new Elements();
        for (Document document : documents) {
            tableElements.addAll(metaData.getTables(document));
        }
        List<Table> tables = new ArrayList<>();
        for (Element tableElement : tableElements) {
            Table table = buildTableMetaData(tableElement);
            List<TableColumn> columnList = new ArrayList<>();
            List<TableColumn> idColumns = new ArrayList<>();
            Elements columnElements = metaData.getTableColumns(tableElement);
            for (Element columnElement : columnElements) {
                Elements columnMetaData = metaData.getColumnMetaData(columnElement);
                TableColumn tableColumn = buildColumnMetaData(columnMetaData);
                if (metaData.getColumnPrimaryKey(columnMetaData)) {
                    if (table.getIdColumn() == null) {
                        table.setIdColumn(tableColumn);
                    }
                    idColumns.add(tableColumn);
                }
                columnList.add(tableColumn);
            }
            table.setColumns(columnList);
            table.setIdColumns(idColumns);
            tables.add(table);
        }
        return tables;
    }

    @Override
    public List<? extends TableColumn> queryColumns(Table table) {
        return table.getColumns();
    }

    @Override
    public Set<String> queryPrimaryKeys(Table table) {
        if (table.getIdColumn() == null) {
            return Collections.emptySet();
        }
        if (table.getIdColumns().size() > 1) {
            return table.getIdColumns().stream().map(TableColumn::getName).collect(Collectors.toSet());
        }
        return Set.of(table.getIdColumn().getName());
//        Set<String> keys = new LinkedHashSet<>();
//        if (tableMate instanceof TableMetaData) {
//            TableMetaData table = ((TableMetaData) tableMate);
//            Elements columns = metaData.getTableColumns(table.element);
//            for (Element column : columns) {
//                Elements meta = metaData.getColumnMetaData(column);
//                if (metaData.getColumnPrimaryKey(meta)) {
//                    keys.add(metaData.getColumnName(meta));
//                }
//            }
//        }
//        return keys;
    }

    @Override
    public List<? extends IndexedKey> queryIndexKeys(Table table) throws Exception {
        return Collections.emptyList();
    }

    @Override
    public List<? extends ForeignKey> queryImportedKeys(Table table) throws Exception {
        return Collections.emptyList();
    }

    @Override
    public List<? extends ForeignKey> queryExportedKeys(Table table) throws Exception {
        return Collections.emptyList();
    }

    @Override
    public String queryTableRemark(Table tableMate) {
        return null;
    }

    @Override
    public String queryColumnRemark(TableColumn columnMate) {
        return null;
    }

    protected Table buildTableMetaData(Element tableElement) {
        Table table = new Table();
        table.setName(metaData.getTableName(tableElement));
        table.setSchema(metaData.getTableSchema(tableElement));
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
        column.setHasDefValue(!StringUtil.isNullOrBlank(column.getDefValue()));
        return column;
    }

    @Data
    @EqualsAndHashCode(callSuper = true)
    protected class TableMetaData extends Table {

        public final Element element;

        public TableMetaData(Element element) {
            this.element = element;
            this.setName(metaData.getTableName(element));
        }
    }

//    protected class ColumnMetaData extends TableMetaData implements MetaDataColumn {
//
//        public final Elements columnMetaData;
//
//        public ColumnMetaData(Element element) {
//            super(element);
//            columnMetaData = metaData.getColumnMetaData(element);
//        }
//
//        @Override
//        public String getName() {
//            return metaData.getColumnName(columnMetaData);
//        }
//
//        @Override
//        public void setType(String string) {
//        }
//
//        @Override
//        public void setTypeInt(int int1) {
//        }
//
//        @Override
//        public void setLength(int int1) {
//        }
//
//        @Override
//        public void setDefValue(String string) {
//        }
//
//        @Override
//        public void setNullable(boolean boolean1) {
//        }
//
//        @Override
//        public void setDecimalDigits(int int1) {
//        }
//
//        @Override
//        public void setAutoIncrement(boolean b) {
//        }
//
//        @Override
//        public void setHasDefValue(boolean b) {
//
//        }
//    }

    protected class HtmlTableMetaDataImpl implements HtmlTableMetaData {

        @Override
        public Elements getTables(Document document) {
            return document.select("table");
        }

        @Override
        public Elements getTableColumns(Element tableElement) {
            Elements tr = tableElement.select("tr");
            if (tr.size() > 0) {
                tr.remove(0);
            }
            return tr;
        }

        @Override
        public Elements getColumnMetaData(Element columnElement) {
            return columnElement.select("td");
        }

        @Override
        public String getTableName(Element tableElement) {
            return tableElement.attr("name");
        }

        @Override
        public String getTableSchema(Element tableElement) {
            return tableElement.attr("schema");
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
