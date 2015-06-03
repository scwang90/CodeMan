package com.codesmither.kernel;

import com.codesmither.factory.ConfigFactory;
import com.codesmither.model.Model;

public class ModelBuilder {

	public Model build() {
		Model model = new Model();
		model.charset = ConfigFactory.getTargetCharset();
		model.packagename = ConfigFactory.getTargetProjectPackage();
		model.author = ConfigFactory.getTargetProjectAuthor();
		model.projectName = ConfigFactory.getTargetProjectName();
		return model;
	}
	
}
