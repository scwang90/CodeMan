package com.generator.drawable2svg.model;

import com.code.smither.engine.api.Model;
import com.code.smither.engine.api.RootModel;
import com.code.smither.engine.api.Task;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * Created by SCWANG on 2017/9/15.
 */
public class Root implements RootModel {

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
    public List<? extends Model> getModels() {
        return drawables;
    }

    @Override
    public void bindModel(Model model) {
        if (model instanceof Drawable) {
            drawable = (Drawable) model;
            drawableName = ((Drawable) model).getName();
        }
    }

    @Override
    public boolean isModelTask(Task task) {
        String path = task.getTemplateFile().getAbsolutePath();
        return path.contains("${drawableName}") || path.matches("\\$\\{drawable\\.\\S+?}");
    }
}
