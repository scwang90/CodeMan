package com.generator.poetry.drawable2svg;

import com.code.smither.engine.Config;
import com.code.smither.engine.api.*;
import com.generator.poetry.drawable2svg.model.Drawable;
import com.generator.poetry.drawable2svg.model.Path;
import com.generator.poetry.drawable2svg.model.Root;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Element;
import org.jsoup.parser.Parser;
import org.jsoup.parser.XmlTreeBuilder;
import org.jsoup.select.Elements;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.List;

/**
 *
 * Created by SCWANG on 2017/9/15.
 */
public class DrawableBuilder implements IModelBuilder {

    private DrawableConfig config;

    public DrawableBuilder(DrawableConfig config) {
        this.config = config;
    }

    @Override
    public IRootModel build() throws Exception {
        Config con = new Config();
        con.setTemplatePath(config.getDrawablePath());
        con.initEmptyFieldsWithDefaultValues();
        ITaskLoader taskLoader = con.getTaskLoader();
        List<ITask> tasks = taskLoader.loadTask(new File(config.getDrawablePath()), new File(config.getDrawablePath()), new IFileFilter() {
            @Override
            public boolean isNeedFilterFile(File file) {
                return !file.getName().endsWith(".xml");
            }
            @Override
            public boolean isNeedFilterPath(File path) {
                return false;
            }
        });
        Root root = new Root();
        for (ITask task : tasks) {
            try (InputStream input = new FileInputStream(task.getTemplateFile())) {
                Elements vectors = Jsoup.parse(input, "UTF-8", "", new Parser(new XmlTreeBuilder())).select("vector");
                if (vectors.size() > 0) {
                    Element vector = vectors.first();
                    Drawable drawable = new Drawable();
                    drawable.setName(task.getTemplateFile().getName().replaceFirst("\\.\\w+", ""));
                    drawable.setViewportWidth(vector.attr("android:viewportWidth"));
                    drawable.setViewportHeight(vector.attr("android:viewportHeight"));

                    Elements paths = vector.select(">path");
                    for (Element pathElement : paths) {
                        Path path = new Path();
                        path.setPathData(pathElement.attr("android:pathData"));
                        path.setFillColor(pathElement.attr("android:fillColor"));
                        drawable.getPaths().add(path);
                    }

                    root.getDrawables().add(drawable);
                }
            }
        }
        return root;
    }

}
