package com.codesmither.apidoc;

import com.codesmither.apidoc.impl.XmlApidocModelBuilder;
import com.codesmither.engine.Engine;

/**
 * APi文档生成引擎
 * Created by SCWANG on 2016/8/19.
 */
public class ApidocEngine extends Engine {

    private final XmlApidocConfig config;

    public ApidocEngine(XmlApidocConfig config) {
        super(config);
        this.config = config;
    }

    public void launch() throws Exception {
        super.launch(new XmlApidocModelBuilder(config));
    }

}
