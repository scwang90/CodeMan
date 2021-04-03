package com.code.smither.project.replace;


import com.code.smither.project.replace.kernel.ReplaceConfig;
import com.code.smither.project.replace.kernel.ReplaceConfigFactory;
import com.code.smither.project.replace.kernel.ReplaceEngine;
import com.code.smither.project.replace.kernel.ReplaceModelBuilder;
import junit.framework.TestCase;

public class ReplaceEngineTester extends TestCase {

    public void testReplaceHis() throws Exception {
        ReplaceConfig config = ReplaceConfigFactory.loadConfig("replace-his.properties");
        config.setForceOverwrite(true);
        new ReplaceEngine(config).launch(new ReplaceModelBuilder());
    }

    public void testReplaceAll() {
        String input = "I like Java,jAva is very easy and jaVa is so popular.";
        String replacement="你被替换了";

        System.out.println(input);
        System.out.println(input.replaceAll("(?i)java", replacement));
    }
}
