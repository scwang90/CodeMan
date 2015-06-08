package com.codesmither.kernel;

import com.codesmither.factory.C3P0Factory;
import com.codesmither.factory.ConfigFactory;
import com.codesmither.model.DatabaseJdbc;
import com.codesmither.model.Model;

public class ModelBuilder {

	public Model build() {
		Model model = new Model();
		model.charset = ConfigFactory.getTargetCharset();
		model.packagename = ConfigFactory.getTargetProjectPackage();
		model.author = ConfigFactory.getTargetProjectAuthor();
		model.projectName = ConfigFactory.getTargetProjectName();
		model.jdbc = new DatabaseJdbc();
		model.jdbc.url = C3P0Factory.getJdbcUrl();
		model.jdbc.driver = C3P0Factory.getDriverClass();
		model.jdbc.usename = C3P0Factory.getUser();
		model.jdbc.password = C3P0Factory.getPassword();
		return model;
	}
	
}
