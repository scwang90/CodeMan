package com.code.smither.engine.api;

import java.util.List;

/**
 * 模版替换 RootModel 接口
 * 用于存储通用信息，如项目相比信息：作者、项目名、包名
 * Created by SCWANG on 2016/8/18.
 */
public interface RootModel extends Model {
    /**
     * 设置当前的 model
     */
    void bindModel(Model model);

    /**
     * 获取数据模型
     * 用于生成代码的数据核心，如 数据库表
     */
    List<? extends Model> getModels();

    /**
     * 是否是模型任务
     */
    boolean isModelTask(Task task);
}
