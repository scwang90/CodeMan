package com.code.smither.engine;

import com.code.smither.engine.api.Model;
import com.code.smither.engine.api.ModelBuilder;
import com.code.smither.engine.api.RootModel;
import com.code.smither.engine.api.Task;
import org.junit.Test;

import java.util.Collections;
import java.util.List;

public class EngineTest {

    @Test
    public void testCopy() throws Exception {
        EngineConfig config = new EngineConfig();

        config.setTargetPath("D:\\opt\\Java\\repository\\maven");
        config.setTemplatePath("E:\\Java\\repository\\maven");
        config.setTemplateProcessAll(false);
        Engine<EngineConfig> engine = new Engine<>(config);

        engine.launch(new ModelBuilder() {
            @Override
            public RootModel build() throws Exception {
                return new RootModel() {
                    @Override
                    public void bindModel(Model model) {

                    }
                    @Override
                    public List<? extends Model> getModels() {
                        return Collections.emptyList();
                    }
                    @Override
                    public boolean isModelTask(Task task) {
                        return false;
                    }
                };
            }
        });

    }

}