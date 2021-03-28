package com.code.smither.project.replace;


import com.code.smither.project.replace.kernel.ReplaceConfig;
import com.code.smither.project.replace.kernel.ReplaceConfigFactory;
import com.code.smither.project.replace.kernel.ReplaceEngine;
import com.code.smither.project.replace.kernel.ReplaceModelBuilder;
import junit.framework.TestCase;

public class ReplaceEngineTester extends TestCase {

    public void testReplaceHis() throws Exception {
        ReplaceConfig config = ReplaceConfigFactory.loadConfig("replace-his.properties");

        new ReplaceEngine(config).launch(new ReplaceModelBuilder());
    }
}
