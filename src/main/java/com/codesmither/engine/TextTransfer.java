package com.codesmither.engine;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.List;

import com.codesmither.factory.ConfigFactory;
import com.codesmither.factory.FreemarkerFactory;
import com.codesmither.model.Model;
import com.codesmither.model.Table;
import com.codesmither.util.FileUtil;

import freemarker.template.Template;
import freemarker.template.TemplateException;

public class TextTransfer {

	private int itask = 0;
	private String fsrc;
	private String ftarget;
	private List<File> tasks = new ArrayList<File>();
	private List<Table> tables;
	private Model model;
	private String packagepath;
	
	public TextTransfer(Model model, File fsrc, File ftarget) {
		// TODO Auto-generated constructor stub
		this.model = model;
		this.tables = model.tables;
		this.fsrc = fsrc.getAbsolutePath();
		this.ftarget = ftarget.getAbsolutePath();
		this.packagepath = model.packagename.replace(".", File.separatorChar+"");
		this.putTask(fsrc);
	}

	private void putTask(File task) {
		// TODO Auto-generated method stub
		if (task.isFile()) {
			tasks.add(task);
		}else if(task.isDirectory()){
			String path = task.getAbsolutePath();
			path = path.replace(fsrc, ftarget);
			path = path.replace("${packagename}", packagepath);
			new File(path).mkdirs();
			File[] list = task.listFiles();
			for (File file : list) {
				putTask(file);
			}
		}
	}

	public boolean hasTask() {
		// TODO Auto-generated method stub
		return itask < tasks.size();
	}

	public String doTask() throws IOException, TemplateException {
		// TODO Auto-generated method stub
		File file = tasks.get(itask++);
		String path = file.getAbsolutePath();
		path = path.replace(fsrc, ftarget);
		path = path.replace("${packagename}", packagepath);
		File outfile = new File(path);
		
		if (file.getName().endsWith(".ftl")) {
			Template template = getTemplate(file);
			for (Table table : tables) {
				String outpath = outfile.getAbsolutePath().replace(".ftl", "");
				Writer out = getFileWriter(new File(outpath.replace("${className}", table.className)));
				model.bindTable(table);
				template.process(model, out);
				out.close();
			}
		} else if(FileUtil.isTextFile(file)){
			Template template = getTemplate(file);
			Writer out = getFileWriter(outfile);
			template.process(model, out);
			out.close();
		} else {
			FileInputStream inputStream = new FileInputStream(file);
			FileOutputStream outputStream = new FileOutputStream(outfile);
			byte[] bytes = new byte[inputStream.available()];
			inputStream.read(bytes);
			outputStream.write(bytes);
			outputStream.close();
			inputStream.close();
			System.gc();
		}
		return path;
	}
	
	private Template getTemplate(File file) throws IOException {
		// TODO Auto-generated method stub
		String charset = ConfigFactory.getTemplateCharset();
		if (charset != null && charset.trim().length() > 0) {
			return FreemarkerFactory.getTemplate(file, charset);
		}
		return FreemarkerFactory.getTemplate(file);
	}

	private Writer getFileWriter(File file) throws IOException{
		String charset = ConfigFactory.getTargetCharset();
		if (charset != null && charset.trim().length() > 0) {
			return new OutputStreamWriter(new FileOutputStream(file),charset);
		}
		return new FileWriter(file);
	}
}
