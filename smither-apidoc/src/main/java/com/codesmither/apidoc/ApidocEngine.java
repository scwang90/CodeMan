package com.codesmither.apidoc;

import com.codesmither.apidoc.model.ApiService;
import com.codesmither.engine.Engine;
import com.codesmither.engine.api.IModelBuilder;
import com.codesmither.engine.api.IRootModel;

/**
 * APi文档生成引擎
 * Created by SCWANG on 2016/8/19.
 */
public class ApidocEngine extends Engine {
    public ApidocEngine(ApidocConfig config) {
        super(config);
    }

    public void launch() throws Exception {
        super.launch(new IModelBuilder() {
            @Override
            public IRootModel build() throws Exception {
                return new ApiService(){
                    {

                    }
                };
            }
        });
    }
}
