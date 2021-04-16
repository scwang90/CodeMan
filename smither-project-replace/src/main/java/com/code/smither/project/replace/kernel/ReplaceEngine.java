package com.code.smither.project.replace.kernel;

import com.code.smither.engine.Engine;
import com.code.smither.engine.api.RootModel;
import com.code.smither.engine.api.Task;

import java.io.*;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;

public class ReplaceEngine extends Engine<ReplaceConfig> {

    private final String targetPath;
    private final String targetPathLog;

    public ReplaceEngine(ReplaceConfig config) {
        super(config);
        config.setTemplateProcessAll(true);
        targetPath = checkPath(new File(config.getTargetPath())).getAbsolutePath();
        targetPathLog = checkPath(new File(config.getTargetPath()+"-Log")).getAbsolutePath();
    }

    @Override
    protected void copyFile(Task task, File file) throws IOException {

    }

    @Override
    protected void processTemplate(RootModel root, File templateFile, File file) throws IOException {
        Replacer replacer = config.getReplacer();

        boolean logged = false;
        ByteArrayOutputStream bufferLog;
        ByteArrayOutputStream bufferFile;
        try (PrintStream logger = new PrintStream(bufferLog = new ByteArrayOutputStream(1024), true, config.getTargetCharset());
             PrintStream print = new PrintStream(bufferFile = new ByteArrayOutputStream(1024), true, config.getTargetCharset())) {

            List<String> lines = Files.readAllLines(Paths.get(templateFile.getAbsolutePath()), Charset.forName(config.getTemplateCharset()));
            for (int i = 0, len = lines.size(); i < len; i++) {
                String line = lines.get(i);
                if (i < len - 1 || line.length() > 0) {
                    String replaced = replacer.replace(line);
                    print.println(replaced);
                    if (!line.equals(replaced)) {
                        logger.println(line);
                        logger.println("->");
                        logger.println(replaced);
                        logger.println();
                        logger.println();
                        logged = true;
                    }
                }
            }
            if (logged) {
                /*
                 * 写文件
                 */
                if (!file.getParentFile().exists() && !file.getParentFile().mkdirs()) {
                    throw new RuntimeException("创建目录失败");
                }
                try (OutputStream op = new FileOutputStream(file)) {
                    op.write(bufferFile.toByteArray());
                }
                /*
                 * 写日志
                 */
                File logFile = new File(file.getAbsolutePath().replace(targetPath, targetPathLog));
                if (!logFile.getParentFile().exists() && !logFile.getParentFile().mkdirs()) {
                    throw new RuntimeException("创建日志目录失败");
                }
                try (OutputStream op = new FileOutputStream(logFile)) {
                    op.write(bufferLog.toByteArray());
                }
            }
        }
    }

    private File checkPath(File file) {
        String path = file.getAbsolutePath();
        while (path.contains("\\..\\")) {
            path = path.replaceAll("[^\\\\|^.]+\\\\\\.\\.\\\\", "");
        }
        while (path.contains("/../")) {
            path = path.replaceAll("[^/|^.]+/\\.\\./", "");
        }
        return new File(path);
    }

}
