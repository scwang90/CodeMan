package com.generator.drawable2svg.model;


import com.code.smither.engine.api.Model;

/**
 * 矢量图对象
 * Created by SCWANG on 2017/9/15.
 */
public class Path implements Model {

    private String fillColor;
    private String pathData;

    public String getFillColor() {
        return fillColor;
    }

    public void setFillColor(String fillColor) {
        this.fillColor = fillColor;
    }

    public String getPathData() {
        return pathData;
    }

    public void setPathData(String pathData) {
        this.pathData = pathData;
    }
}
