package com.code.smither.engine.api;

/**
 * 任务执行器
 */
public interface ITaskRunner {
    void run(ITask task, IRootModel root, IConfig config) throws Exception;
}
