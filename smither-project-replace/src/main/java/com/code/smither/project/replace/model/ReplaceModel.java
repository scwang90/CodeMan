package com.code.smither.project.replace.model;

import com.code.smither.engine.api.Model;
import com.code.smither.engine.api.RootModel;
import com.code.smither.engine.api.Task;

import java.util.Collections;
import java.util.List;

public class ReplaceModel implements RootModel {

    @Override
    public void bindModel(Model model) {

    }

    @Override
    public List<? extends Model> getModels() {
        return Collections.emptyList();
    }

    @Override
    public boolean isModelTask(Task task) {
        return false;
    }
}
