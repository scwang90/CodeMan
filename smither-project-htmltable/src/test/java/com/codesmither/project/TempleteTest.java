package com.codesmither.project;

import com.codesmither.project.base.ProjectEngine;
import com.codesmither.project.base.api.Converter;
import com.codesmither.project.base.impl.ConfigConverter;
import com.codesmither.project.database.HtmlTableConfig;
import com.codesmither.project.database.factory.ConfigFactory;
import com.codesmither.project.database.impl.HtmlTableModelBuilder;
import com.codesmither.project.database.impl.HtmlTableSource;
import org.junit.Test;

/**
 *
 * Created by SCWANG on 2016/8/18.
 */
public class TempleteTest {

    @Test
    public void HtmlTableTemplete() {
        try {
            HtmlTableConfig config = ConfigFactory.loadConfig("config.properties");
            ProjectEngine engine = new ProjectEngine(config);

            HtmlTableSource source = new HtmlTableSource(config);
            engine.launch(new HtmlTableModelBuilder(config, source));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
