package com.generator.drawable2svg.model;

import com.code.smither.engine.api.Model;

import java.util.ArrayList;
import java.util.List;

/**
 * 矢量图对象
 * Created by SCWANG on 2017/9/15.
 */
public class Drawable implements Model {

    private String name;
    private String viewportWidth;
    private String viewportHeight;

    private List<Path> paths = new ArrayList<>();

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getViewportWidth() {
        return viewportWidth;
    }

    public void setViewportWidth(String viewportWidth) {
        this.viewportWidth = viewportWidth;
    }

    public String getViewportHeight() {
        return viewportHeight;
    }

    public void setViewportHeight(String viewportHeight) {
        this.viewportHeight = viewportHeight;
    }

    public List<Path> getPaths() {
        return paths;
    }

    public void setPaths(List<Path> paths) {
        this.paths = paths;
    }
}
