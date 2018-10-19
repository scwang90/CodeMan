package com.generator.qiniu;

import com.code.smither.engine.Engine;
import com.generator.poetry.drawable2svg.DrawableBuilder;
import com.generator.poetry.drawable2svg.DrawableConfig;
import org.junit.Test;

/**
 *
 * Created by SCWANG on 2017/9/16.
 */
public class Drawable2SvgTester {

    @Test
    public void testSvg() throws Exception {
        DrawableConfig config = new DrawableConfig();
        config.setDrawablePath("E:\\Workspaces\\android-studio\\Poetry\\poetry-3.x\\src\\main\\res\\drawable");
        config.setTargetPath("E:\\Workspaces\\android-studio\\Poetry\\poetry-1.x");
        config.setTemplatePath("E:\\Workspaces\\projects-idea\\CodeSmither\\trunk\\templates\\svg-drawable");

        Engine engine = new Engine(config);
        engine.launch(new DrawableBuilder(config));


    }
}
