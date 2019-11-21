package com.code.smither.engine.api;

/**
 * 任务执行器
 */
public interface TaskRunner {
    void run(Task task, RootModel root, Config config) throws Exception;
}
