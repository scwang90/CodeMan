package com.code.smither.project.database;

import com.code.smither.engine.EngineConfig;
import com.code.smither.project.base.ProjectConfig;
import com.code.smither.project.base.util.StringUtil;
import com.code.smither.project.database.api.DbFactory;
import com.code.smither.project.database.factory.C3P0Factory;
import com.code.smither.project.database.factory.DefaultFactory;
import com.code.smither.project.database.factory.SshDbFactory;
import com.code.smither.project.database.factory.TableSourceFactory;
import com.code.smither.project.database.impl.DbTableSource;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 带数据库的配置
 * Created by SCWANG on 2016/8/18.
 */
@SuppressWarnings("unused")
@Data
@EqualsAndHashCode(callSuper = true)
public class DataBaseConfig extends ProjectConfig {

    protected String dbUrl;
    protected String dbDriver;
    protected String dbUsername;
    protected String dbPassword;
    protected String dbConfigName;

    protected int sshPort = 22;
    protected String sshHost = "";
    protected String sshUser = "";
    protected String sshPassword = "";

    protected transient DbFactory dbFactory = null;
    protected transient DbTableSource tableSource = null;

    @Override
    public EngineConfig initEmptyFieldsWithDefaultValues() {
        super.initEmptyFieldsWithDefaultValues();
        if (dbFactory == null) {
            if (StringUtil.isNullOrBlank(dbConfigName)) {
                if (StringUtil.isNotNullAndBlank(sshHost)) {
                    dbFactory = new SshDbFactory(this);
                } else {
                    dbFactory = new DefaultFactory(this);
                }
            } else {
                dbFactory = C3P0Factory.getInstance(getDbConfigName());
            }
        }
        if (tableSource == null) {
            tableSource = TableSourceFactory.getInstance(this, dbFactory);
        }
        return this;
    }

}
