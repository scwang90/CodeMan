package com.generator.drawable2svg;

import com.code.smither.engine.EngineConfig;

/**
 *
 * Created by SCWANG on 2017/9/15.
 */
public class DrawableConfig extends EngineConfig {

    protected String drawablePath;

    public String getDrawablePath() {
        return drawablePath;
    }

    public void setDrawablePath(String drawablePath) {
        this.drawablePath = drawablePath;
    }
}
