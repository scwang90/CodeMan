package com.code.smither.project.base.api;

import com.code.smither.engine.api.RootModel;

/**
 * 带程序设计语言支持的 RootModel
 */
public interface LangRootModel extends RootModel {

    /**
     * 绑定一个设计语言
     */
    void bindClassConverter(ClassConverter converter);
}
