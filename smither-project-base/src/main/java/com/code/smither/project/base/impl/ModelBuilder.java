package com.code.smither.project.base.impl;

import com.code.smither.engine.api.IModelBuilder;
import com.code.smither.engine.api.IRootModel;
import com.code.smither.project.base.ProjectConfig;
import com.code.smither.project.base.api.DbFactory;
import com.code.smither.project.base.api.TableSource;
import com.code.smither.project.base.model.DatabaseJdbc;
import com.code.smither.project.base.model.Model;
import com.code.smither.project.base.model.Table;

import java.util.List;

public class ModelBuilder implements IModelBuilder {

	protected final ProjectConfig config;
	protected final DbFactory factory;
	protected final TableSource tableSource;

	public ModelBuilder(ProjectConfig config, DbFactory factory, TableSource tableSource) {
		this.config = config;
		this.factory = factory;
		this.tableSource = tableSource;
	}

	@Override
	public IRootModel build() throws Exception {
		return build(new Model(), config, factory, tableSource.build());
	}

	public static Model build(Model model, ProjectConfig config, DbFactory factory, List<Table> tables) {
		model.setAuthor(config.getTargetProjectAuthor());
		model.setCharset(config.getTargetCharset());
		model.setPackageName(config.getTargetProjectPackage());
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