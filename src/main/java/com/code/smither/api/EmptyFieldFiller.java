package com.code.smither.api;

/**
 * 空字段填充器
 * Created by SCWANG on 2016/8/19.
 */
public interface EmptyFieldFiller {
    IRootModel fill(IRootModel model);
}
