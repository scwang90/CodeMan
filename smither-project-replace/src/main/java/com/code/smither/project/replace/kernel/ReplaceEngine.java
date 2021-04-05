package com.code.smither.project.replace.kernel;

import com.code.smither.engine.Engine;
import com.code.smither.engine.EngineConfig;
import com.code.smither.engine.api.Config;
import com.code.smither.engine.api.ModelBuilder;
import com.code.smither.engine.api.RootModel;
import com.code.smither.engine.api.Task;
import com.code.smither.project.replace.model.ReplaceItem;
import freemarker.template.TemplateException;

import java.io.*;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class ReplaceEngine extends Engine<ReplaceConfig> {

    public ReplaceEngine(ReplaceConfig config) {
        super(config);
        config.setTemplateProcessAll(false);
    }

    @Override
    protected void processTemplate(RootModel root, File templateFile, File file) throws IOException {
        Replacer replacer = config.getReplacer();
        List<String> lines = Files.readAllLines(Paths.get(templateFile.getAbsolutePath()), Charset.forName(config.getTemplateCharset()));
        try(PrintStream print = new PrintStream(file, config.getTargetCharset())) {
            for (String line : lines) {
                print.println(replacer.replace(line));
            }
        }
    }
}
