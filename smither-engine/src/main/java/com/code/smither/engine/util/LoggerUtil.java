package com.code.smither.engine.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.LogManager;
import java.util.logging.Logger;

public class LoggerUtil {

    private static final Logger logger = Logger.getLogger(LoggerUtil.class.getName());

    public static void loadLoggingConfig() {
        File file = new File("../resources/logging.properties");
        if (!file.exists()) {
            file = new File("resources/logging.properties");
        }
        try(FileInputStream fis = new FileInputStream(file)) {
            LogManager manager = LogManager.getLogManager();
            manager.readConfiguration(fis);
        } catch (IOException e) {
            logger.log(Level.WARNING, "loadLoggingConfig", e);
        }
    }

}
