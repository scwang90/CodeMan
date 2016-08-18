package com.codesmither.project.base.api;


import com.codesmither.project.base.model.Table;

import java.util.List;

/**
 * 表源
 * Created by SCWANG on 2016/8/1.
 */
public interface TableSource {

    List<Table> build() throws Exception;

}