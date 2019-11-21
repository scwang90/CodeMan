package com.code.smither.apidoc.model;

import com.code.smither.engine.api.Model;
import com.code.smither.engine.api.RootModel;

import java.util.List;

/**
 * APi 服务器
 * Created by SCWANG on 2016/8/19.
 */
@SuppressWarnings("unused")
public class ApiService extends HtmlModel implements RootModel {

    private String name;
    private String displayName;
    private String basePath;
    private String description;
    private List<ApiModule> modules;
    private List<ApiHeader> headers;

    private transient String moduleName;
    private transient ApiModule module;

    public List<ApiModule> getModules() {
        return modules;
    }

    public void setModules(List<ApiModule> modules) {
        this.modules = modules;
    }

    public List<ApiHeader> getHeaders() {
        return headers;
    }

    public void setHeaders(List<ApiHeader> headers) {
        this.headers = headers;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }

    public String getBasePath() {
        return basePath;
    }

    public void setBasePath(String basePath) {
        this.basePath = basePath;
    }

    public String getModuleName() {
        return moduleName;
    }

    public void setModuleName(String moduleName) {
        this.moduleName = moduleName;
    }

    public ApiModule getModule() {
        return module;
    }

    public void setModule(ApiModule module) {
        this.module = module;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    //<editor-fold desc="接口实现">
    @Override
    public List<? extends Model> getModels() {
        return modules;
    }

    @Override
    public void bindModel(Model model) {
        if (model instanceof ApiModule) {
            module = (ApiModule) model;
            moduleName = ((ApiModule) model).getName();
        }
    }
    //</editor-fold>


}
