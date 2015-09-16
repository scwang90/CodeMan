package com.codesmither.engine;

import java.io.File;
import java.io.PrintStream;
import java.sql.Connection;

import com.codesmither.factory.C3P0Factory;
import com.codesmither.factory.ConfigFactory;
import com.codesmither.kernel.ConfigConverter;
import com.codesmither.kernel.Converter;
import com.codesmither.kernel.ModelBuilder;
import com.codesmither.kernel.TableBuilder;
import com.codesmither.model.Model;

public class Engine {

	private String templates;
	private String target;
	
	public Engine() {
		// TODO Auto-generated constructor stub
		target = ConfigFactory.getTargetPath();
		templates = ConfigFactory.getTemplatePath();
	}
	
	public Engine(String templates,String target) {
		// TODO Auto-generated constructor stub
		this.templates = templates;
		this.target = target;
	}
	
	protected void doInBackground(PrintStream print) throws Exception {
		// TODO Auto-generated method stub
		File ftemplates = new File(templates);
		File ftarget = new File(target);
		if (!ftemplates.exists()) {
			throw new Exception("源项目不存在！");
		}
		if (!ftarget.exists() && !ftarget.mkdirs()) {
			throw new Exception("创建目标项目失败！");        
		}

		Connection connection = C3P0Factory.getConnection();
		Converter converter = new ConfigConverter();
		ModelBuilder modelBuilder = new ModelBuilder();
		TableBuilder tableBuilder = new TableBuilder(connection,converter );
		Model model = modelBuilder.build();
		model.tables = tableBuilder.build();
		TextTransfer transfer = new TextTransfer(model,ftemplates,ftarget);
		while (transfer.hasTask()) {
			print.println(transfer.doTask());
		}
	}
	
}
