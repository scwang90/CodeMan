package com.generator.replace.model;

import com.code.smither.project.base.model.TableColumn;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
public class ReplaceColumn extends TableColumn {
    
    private String replaceName;
    
    private String replaceRemark;

}
