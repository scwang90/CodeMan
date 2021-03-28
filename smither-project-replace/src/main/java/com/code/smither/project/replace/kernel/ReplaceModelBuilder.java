package com.code.smither.project.replace.kernel;


import com.code.smither.engine.api.ModelBuilder;
import com.code.smither.engine.api.RootModel;
import com.code.smither.project.replace.model.ReplaceModel;

public class ReplaceModelBuilder implements ModelBuilder {

    @Override
    public RootModel build() throws Exception {
        return new ReplaceModel();
    }
}
