package com.code.smither;

//import com.code.smither.engine.api.Model;
//import com.code.smither.engine.api.RootModel;
//import com.code.smither.engine.api.Task;
//import com.code.smither.project.database.DataBaseConfig;
//import com.code.smither.project.database.DataBaseEngine;
//import com.code.smither.project.database.factory.DbConfigFactory;
import com.code.smither.App;
import org.junit.Test;

import java.util.Collections;
import java.util.List;

public class EngineTest {

    @Test
    public void testMethod() {
        System.out.println("Hello Method " + new App());
    }

//    @Test
//    public void DataBaseMidaierPoints() {
//        try {
//            DataBaseConfig config = DbConfigFactory.loadConfig("midaier-points.properties");
//            DataBaseEngine engine = new DataBaseEngine(config);
//            engine.launch();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
//
//    @Test
//    public void testCopy() throws Exception {
//        var config = new EngineConfig();
//
//        config.setTargetPath("D:\\opt\\Java\\repository\\maven");
//        config.setTemplatePath("E:\\Java\\repository\\maven");
//        config.setTemplateProcessAll(false);
//        Engine<EngineConfig> engine = new Engine<>(config);
//
//        engine.launch(() -> new RootModel() {
//            @Override
//            public void bindModel(Model model) {
//
//            }
//            @Override
//            public List<? extends Model> getModels() {
//                return Collections.emptyList();
//            }
//            @Override
//            public boolean isModelTask(Task task) {
//                return false;
//            }
//        });
//
//    }

}