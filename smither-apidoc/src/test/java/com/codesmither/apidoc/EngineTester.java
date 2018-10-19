package com.code.smither.apidoc;

import com.code.smither.apidoc.factory.ConfigFactory;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.nodes.Node;
import org.jsoup.select.Elements;
import org.junit.Test;

import java.beans.XMLEncoder;
import java.io.BufferedOutputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Stack;

/**
 * EngineTester
 * Created by SCWANG on 2016/8/19.
 */
public class EngineTester {

    @Test
    public void testElement() throws IOException {
//        File file = new File("../templates-datasource/api-doc-testapp.xml");
//        Element service = Jsoup.parse(file, "UTF-8").select("service").first();
        Element service = Jsoup.parse("<service><service><module></module></service></service>").select("service").first();
        Elements modules = service.select(">module");
        for (Element module : modules) {
            System.out.println(module);
        }
    }


    @Test
    public void testXml() throws IOException {

        Document parse = Jsoup.parse(new File("../templates-datasource/api-doc-testapp.xml"), "UTF-8");
        Stack<Node> stack = new Stack<>();
        stack.push(parse.select("service").first());
        while (!stack.empty()) {
            Node pop = stack.pop();
            printStack(stack, pop.nodeName());
            List<Node> nodes = pop.childNodes();
            for (Node node : nodes) {
                if (node instanceof Element) {
                    stack.push(node);
                }
            }
        }
    }

    private void printStack(Stack stack, String print) {
        System.out.print("\t\t\t\t\t\t\t\t\t\t".substring(0, stack.size()));
        System.out.println(print);
    }

    @Test
    public void engine() {
        try {
            XmlApiDocConfig config = ConfigFactory.loadConfig("config.properties");
            ApiDocEngine engine = new ApiDocEngine(config);
            engine.launch();
        } catch (Throwable e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) throws IOException {
        XmlApiDocConfig config = ConfigFactory.loadConfig("config.properties");
        System.out.println(formatXML(config));
    }

    public static <T> String formatXML(T entity) {
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        XMLEncoder encoder = new XMLEncoder(new BufferedOutputStream(out));
        encoder.writeObject(entity);
        encoder.close();
        return out.toString();
    }

}
