package com.generator.poetry.drawable2svg.model;

import com.code.smither.engine.api.IModel;
import com.code.smither.engine.api.IRootModel;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * Created by SCWANG on 2017/9/15.
 */
public class Root implements IRootModel {

    private List<Drawable> drawables = new ArrayList<>();

    private String drawableName;
    private Drawable drawable;

    public List<Drawable> getDrawables() {
        return drawables;
    }

    public void setDrawables(List<Drawable> drawables) {
        this.drawables = drawables;
    }

    public String getDrawableName() {
        return drawableName;
    }

    public void setDrawableName(String drawableName) {
        this.drawableName = drawableName;
    }

    public Drawable getDrawable() {
        return drawable;
    }

    public void setDrawable(Drawable drawable) {
        this.drawable = drawable;
    }

    @Override
    public List<? extends IModel> getModels() {
        return drawables;
    }

    @Override
    public void bindModel(IModel model) {
        if (model instanceof Drawable) {
            drawable = (Drawable) model;
            drawableName = ((Drawable) model).getName();
        }
    }
}
