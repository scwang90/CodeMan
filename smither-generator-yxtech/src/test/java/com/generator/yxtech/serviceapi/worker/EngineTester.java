package com.generator.yxtech.serviceapi.worker;

import com.codesmither.apidoc.ApidocEngine;
import com.codesmither.apidoc.XmlApidocConfig;
import com.codesmither.apidoc.factory.ConfigFactory;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.nodes.Node;
import org.jsoup.select.Elements;
import org.junit.Test;

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
    public void engineWorker() {
        try {
            XmlApidocConfig config = ConfigFactory.loadConfig("worker.properties");
            ApidocEngine engine = new ApidocEngine(config);
            engine.launch();
        } catch (Throwable e) {
            e.printStackTrace();
        }
    }

}
