package com.generator.excel2db.api;

import com.generator.excel2db.model.Service;

import java.util.List;

/**
 * Model构造器
 * Created by SCWANG on 2016/12/19.
 */
public interface ModelBuilder {

    List<Service> build(List<List<String>> rows);

}
