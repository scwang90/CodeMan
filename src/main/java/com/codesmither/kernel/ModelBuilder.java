package com.codesmither.kernel;

import com.codesmither.factory.C3P0Factory;
import com.codesmither.factory.ConfigFactory;
import com.codesmither.factory.api.DbFactory;
import com.codesmither.kernel.api.Config;
import com.codesmither.model.DatabaseJdbc;
import com.codesmither.model.Model;
import com.codesmither.model.Table;

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
		model.getJdbc().setUsename(factory.getUser());
		model.getJdbc().setPassword(factory.getPassword());
		model.setTables(tables);
		return model;
	}
	
}
