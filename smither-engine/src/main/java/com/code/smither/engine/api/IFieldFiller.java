package com.code.smither.engine.api;

/**
 * 空字段填充器
 * Created by SCWANG on 2016/8/19.
 */
public interface IFieldFiller {
    IRootModel fill(IRootModel model);
}
