package com.htmltabletomodel;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.junit.Test;

import java.io.*;

/**
 * JsoupTester
 * Created by SCWANG on 2016/7/29.
 */
public class JsoupTester {

    @Test
    public void testFile() throws IOException {
        String tmp, path = "./tables/table.html";
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(path), "utf-8"))) {
            while ((tmp = reader.readLine()) != null) {
                System.out.println(tmp);
            }
        }
    }

    @Test
    public void test() throws IOException {
        String path = "./tables/table.html";
        Document parse = Jsoup.parse(new File(path), "utf-8");
        Elements table = parse.select("table");
        for (Element row : table) {
            System.out.println(row.toString());
        }
    }

}
