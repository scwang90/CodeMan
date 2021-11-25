package com.generator.replace.model;

import com.code.smither.project.base.model.Table;

import lombok.Data;


@Data
public class ReplaceTable extends Table {

    private String replaceName;
    
    private String replaceRemark;

}
