package com.code.smither.project.base.model;

import lombok.AllArgsConstructor;
import lombok.Data;

/**
 * 数据库列枚举值
 */
@Data
@AllArgsConstructor
public class EnumValue {

    private int value;
    private String name;

}
