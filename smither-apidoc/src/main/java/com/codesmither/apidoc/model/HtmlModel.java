package com.codesmither.apidoc.model;

/**
 * 用于生成HTML模版的通用Model
 * Created by SCWANG on 2016/8/19.
 */
@SuppressWarnings("unused")
public class HtmlModel {

    public String getId(){
        return String.format("Id%#x",hashCode());
    }
}
