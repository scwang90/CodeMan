package com.codesmither.apidoc.model;

import com.codesmither.engine.api.IModel;
import com.codesmither.engine.api.IRootModel;

import java.util.List;

/**
 * APi 服务器
 * Created by SCWANG on 2016/8/19.
 */
public class ApiService implements IRootModel {

    private String name;
    private String description;
    private List<ApiModule> modules;

    public List<ApiModule> getModules() {
        return modules;
    }

    public void setModules(List<ApiModule> modules) {
        this.modules = modules;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    //<editor-fold desc="接口实现">
    @Override
    public List<? extends IModel> getModels() {
        return modules;
    }

    @Override
    public void bindModel(IModel model) {

    }
    //</editor-fold>


}
