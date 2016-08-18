package com.codesmither.engine;

import com.codesmither.factory.ConfigFactory;
import com.codesmither.kernel.ConfigConverter;
import com.codesmither.kernel.HtmlTableSource;
import com.codesmither.kernel.api.Config;
import com.codesmither.kernel.api.HtmlTableConfig;
import com.codesmither.model.Table;
import com.codesmither.model.TableColumn;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.junit.Test;

import java.sql.Types;

/**
 * TempleteTest
 * Created by Administrator on 2015/9/16.
 */
public class TempleteTest {

    @Test
    public void Templete() {
        try {
            Config config = ConfigFactory.loadConfig("config.properties");
            Engine engine = new Engine(config);
            engine.doInBackground(System.out);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    public void TempleteHtmlTable() {
        try {
            HtmlTableConfig config = ConfigFactory.loadHtmlTableConfig("htmltable.properties");
            Engine engine = new Engine(config);
            engine.doHtmlTableInBackground(System.out, config);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    public void TestCloudModel() {
        try {
            HtmlTableConfig config = ConfigFactory.loadHtmlTableConfig("htmltable.properties");
            Engine engine = new Engine(config);
            engine.doHtmlTableInBackground(System.out, new HtmlTableSource(config.getHtmlTablePath(),config.getHtmlTableCharset(), new ConfigConverter(config)) {
                {
                    metaData = new HtmlTableMetaDataImpl(){
                        @Override
                        public String getColumnType(Elements columnMetaData) {
                            if (getColumnLenght(columnMetaData) > 0) {
                                return "varchar";
                            }
                            return columnMetaData.get(3).text();
                        }

                        @Override
                        public int getColumnTypeInt(Elements columnMetaData) {
                            String text = columnMetaData.get(3).text();
                            if (text.endsWith("符串")) {
                                return Types.NVARCHAR;
                            } else if (text.contains("日期")){
                                return Types.DATE;
                            } else if (text.toLowerCase().contains("binary")){
                                return Types.BINARY;
                            } else if (text.toLowerCase().contains("bool")){
                                return Types.BIT;
                            } else if (text.toLowerCase().contains("float")){
                                return Types.FLOAT;
                            }
                            if (columnMetaData.get(2).text().endsWith("日期")) {
                                return Types.DATE;
                            } else if (columnMetaData.get(2).text().startsWith("是否")) {
                                return Types.BIT;
                            }
                            if (columnMetaData.get(1).text().endsWith("Date")) {
                                return Types.DATE;
                            }
                            return Types.NVARCHAR;
                        }

                        @Override
                        public int getColumnLenght(Elements columnMetaData) {
                            try {
                                return Integer.parseInt(columnMetaData.get(4).text().replace(",",""));
                            } catch (NumberFormatException ignored) {
                            }
                            return -1;
                        }
                    };
                }

                @Override
                protected void buildTableMetaData(Element tableElement, Table table) {
                    Element element = tableElement.previousElementSibling().clone();
                    table.setRemark(element.select("strong").text());
                    table.setName(element.select("em").text());
                }

                @Override
                protected void buildColumnMetaData(TableColumn column, Elements columnMetaData) {
                    column.setName      (columnMetaData.get(1).text().replace(" ",""));
                    column.setType      (metaData.getColumnType     (columnMetaData));
                    column.setTypeInt   (metaData.getColumnTypeInt  (columnMetaData));
                    column.setLenght    (metaData.getColumnLenght   (columnMetaData));
                    column.setDefvalue  ("");
                    column.setNullable  (true);
                    column.setRemark    (columnMetaData.get(2).text());
                    column.setAutoIncrement(false);
                }

            });
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
