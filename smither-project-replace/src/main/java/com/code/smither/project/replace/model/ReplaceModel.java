package com.code.smither.project.replace.model;

import com.code.smither.engine.api.Model;
import com.code.smither.engine.api.RootModel;

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

}
