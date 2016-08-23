package com.codesmither.engine.impl;

import com.codesmither.engine.api.IModel;
import com.codesmither.engine.api.IRootModel;
import com.codesmither.engine.api.IRootModelMap;

import java.util.HashMap;
import java.util.List;

/**
 * DefaultModelToMap
 * Created by SCWANG on 2016/8/22.
 */
public class DefaultModelToMap extends HashMap<String, Object> implements IRootModelMap {

    private IRootModel model;

    public static IRootModel modelToMap(IRootModel model) {
        return new DefaultModelToMap(model);
    }

    public DefaultModelToMap(IRootModel model) {
        this.model = model;
    }

    @Override
    public List<? extends IModel> getModels() {
        return model.getModels();
    }

    @Override
    public void bindModel(IModel model) {
        this.model.bindModel(model);
    }
}
