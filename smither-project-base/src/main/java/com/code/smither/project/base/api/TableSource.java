package com.code.smither.project.base.api;


import com.code.smither.project.base.constant.Database;
import com.code.smither.project.base.model.Table;
import javax.annotation.Nonnull;
import javax.annotation.Nullable;

import java.util.List;

/**
 * 表源
 * Created by SCWANG on 2016/8/1.
 */
public interface TableSource {

    @Nullable Database getDatabase();
    @Nonnull List<Table> build() throws Exception;

}