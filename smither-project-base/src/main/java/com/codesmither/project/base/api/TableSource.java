package com.codesmither.project.base.api;


import com.codesmither.project.base.constant.Database;
import com.codesmither.project.base.model.Table;
import com.sun.istack.internal.NotNull;
import com.sun.istack.internal.Nullable;

import java.util.List;

/**
 * 表源
 * Created by SCWANG on 2016/8/1.
 */
public interface TableSource {

    @Nullable Database getDatabase();
    @NotNull List<Table> build() throws Exception;

}