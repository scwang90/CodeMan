package com.codesmither.kernel;

import com.codesmither.factory.C3P0Factory;
import com.codesmither.factory.ConfigFactory;
import com.codesmither.kernel.api.Config;
import com.codesmither.model.DatabaseJdbc;
import com.codesmither.model.Model;

/**
 * 模板Model构建器
 * Created by SCWANG on 2015-07-04.
 */
public class ModelBuilder {

	public Model build(Config config) {
		Model model = new Model();
		model.setCharset(config.getTargetCharset());
		model.setPackageName(config.getTargetProjectPackage());
		model.setAuthor(config.getTargetProjectAuthor());
		model.setProjectName(config.getTargetProjectName());
		model.setJdbc(new DatabaseJdbc());
		model.getJdbc().setUrl(C3P0Factory.getJdbcUrl());
		model.getJdbc().setDriver(C3P0Factory.getDriverClass());
		model.getJdbc().setUsename(C3P0Factory.getUser());
		model.getJdbc().setPassword(C3P0Factory.getPassword());
		return model;
	}
	
}
