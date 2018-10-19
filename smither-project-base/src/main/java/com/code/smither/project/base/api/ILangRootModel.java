package com.code.smither.project.base.api;

import com.code.smither.engine.api.IRootModel;

/**
 * 带程序设计语言支持的 RootMoel
 */
public interface ILangRootModel extends IRootModel {

    /**
     * 绑定一个设计语言
     */
    void bindClassConverter(ClassConverter converter);
}
