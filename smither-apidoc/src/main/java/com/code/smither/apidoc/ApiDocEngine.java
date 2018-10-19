package com.code.smither.apidoc;

import com.code.smither.apidoc.impl.XmlApidocModelBuilder;
import com.code.smither.engine.Engine;

/**
 * APi文档生成引擎
 * Created by SCWANG on 2016/8/19.
 */
public class ApiDocEngine extends Engine {

    private final XmlApiDocConfig config;

    public ApiDocEngine(XmlApiDocConfig config) {
        super(config);
        this.config = config;
    }

    public void launch() throws Exception {
        super.launch(new XmlApidocModelBuilder(config));
    }

}
