package com.code.smither.project.base.model;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;

/**
 * 特性列表（可以指定使用模板中的某种特性功能或代码）
 */
@Data
@AllArgsConstructor
public class Features {

    private List<String> features;

    public boolean has(String feature) {
        if (features != null) {
            return features.contains(feature);
        }
        return false;
    }
}
