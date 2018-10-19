package com.code.smither.kernel;

import com.code.smither.factory.api.DbFactory;
import com.code.smither.kernel.api.Config;
import com.code.smither.model.DatabaseJdbc;
import com.code.smither.model.Model;
import com.code.smither.model.Table;

import java.util.List;

/**
 * 模板Model构建器
 * Created by SCWANG on 2015-07-04.
 */
public class ModelBuilder {

	public Model build(Config config, DbFactory factory, List<Table> tables) {
		Model model = new Model();
		model.setCharset(config.getTargetCharset());
		model.setPackageName(config.getTargetProjectPackage());
		model.setAuthor(config.getTargetProjectAuthor());
		model.setProjectName(config.getTargetProjectName());
		model.setJdbc(new DatabaseJdbc());
		model.getJdbc().setUrl(factory.getJdbcUrl());
		model.getJdbc().setDriver(factory.getDriverClass());
		model.getJdbc().setUsername(factory.getUser());
		model.getJdbc().setPassword(factory.getPassword());
		model.setTables(tables);
		return model;
	}
	
}
