package com.code.smither.engine;

import com.code.smither.factory.FreemarkerFactory;
import com.code.smither.kernel.api.Config;
import com.code.smither.model.Model;
import com.code.smither.model.Table;
import com.code.smither.task.*;
import com.code.smither.task.FileFilter;
import com.code.smither.util.FileUtil;
import freemarker.template.Template;
import freemarker.template.TemplateException;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

/**
 * 任务转换器
 * 根据模板文件转成要执行的任务
 * Created by SCWANG on 2015-07-04.
 */
public class TaskTransfer {

	private int itask = 0;
	private String fsrc;
	private Config config;
	private String ftarget;
	private List<Task> tasks = new ArrayList<>();
	private List<Table> tables;
	private Model model;
	private String packagepath;

	public TaskTransfer(Config config, Model model, File fsrc, File ftarget, FileFilter fileFilter) {
		this.model = model;
		this.config = config;
		this.tables = model.getTables();
		this.fsrc = fsrc.getAbsolutePath();
		this.ftarget = ftarget.getAbsolutePath();
		this.packagepath = model.getPackageName().replace(".", File.separatorChar + "");
		this.tasks = new TaskLoader(fsrc,ftarget,fileFilter).loadTask();
		this.putTask(tasks);
	}

	private void putTask(List<Task> tasks) {
		for (Task task : tasks) {
			String path = task.getFile().getParent();
			path = path.replace(fsrc, ftarget);
			path = path.replace("${packagePath}", packagepath);
			new File(path).mkdirs();
		}
	}

	public boolean hasTask() {
		return itask < tasks.size();
	}

	public String doTask() throws IOException, TemplateException {
		Task task = tasks.get(itask++);
		String path = task.getFile().getAbsolutePath();
		path = path.replace(fsrc, ftarget);
		path = path.replace("${packagePath}", packagepath);
		File outfile = new File(path);

		StringBuilder log = new StringBuilder(path+"\r\n");
		if (task.getFile().getName().endsWith(".ftl")) {
			Template template = getTemplate(task.getFile());
			for (Table table : tables) {
				String outpath = outfile.getAbsolutePath().replace(".ftl", "").replace("${className}", table.getClassName());
				log.append("  =>>");
				log.append(outpath);
				log.append("\r\n");
				Writer out = getFileWriter(new File(outpath));
//				model.bindTable(table);
				template.process(model, out);
				out.close();
			}
		} else if(FileUtil.isTextFile(task.getFile())){
			log.append("  =>>");
			log.append(outfile.getAbsolutePath());
			log.append("\r\n");
			Template template = getTemplate(task.getFile());
			Writer out = getFileWriter(outfile);
			template.process(model, out);
			out.close();
		} else {
			log.append("  =>>");
			log.append(outfile.getAbsolutePath());
			log.append("\r\n");
			FileInputStream inputStream = new FileInputStream(task.getFile());
			FileOutputStream outputStream = new FileOutputStream(outfile);
			byte[] bytes = new byte[inputStream.available()];
			inputStream.read(bytes);
			outputStream.write(bytes);
			outputStream.close();
			inputStream.close();
			System.gc();
		}
		return log.toString();
	}
	
	private Template getTemplate(File file) throws IOException {
		String charset = config.getTemplateCharset();
		if (charset != null && charset.trim().length() > 0) {
			return FreemarkerFactory.getTemplate(file, charset);
		}
		return FreemarkerFactory.getTemplate(file);
	}

	private Writer getFileWriter(File file) throws IOException{
		String charset = config.getTargetCharset();
		if (charset != null && charset.trim().length() > 0) {
			return new OutputStreamWriter(new FileOutputStream(file),charset);
		}
		return new FileWriter(file);
	}
}
