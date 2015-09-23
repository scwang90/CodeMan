package com.codesmither.engine;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import org.junit.Test;

import com.codesmither.factory.C3P0Factory;
import com.codesmither.kernel.ConfigConverter;
import com.codesmither.kernel.Converter;
import com.codesmither.kernel.TableBuilder;
import com.codesmither.model.Table;
import com.codesmither.util.JacksonUtil;

public class EngineTest {

	@Test
	public void Engine() throws SQLException {
		Connection connection = C3P0Factory.getConnection();
		Converter converter = new ConfigConverter();
		TableBuilder builder = new TableBuilder(connection,converter );
		for (Table table : builder.build()) {
			System.out.println(JacksonUtil.toJson(table));
		}
	}

	@Test
	public void fileCreate() throws IOException{
		File file = new File("C:/Users/SCWANG/Desktop/test.txt");
		FileWriter writer = new FileWriter(file);
		writer.write("hello");
		writer.close();
	}
	
	@Test
	public void fileMakedir(){
		File file = new File("C:\\Users\\SCWANG\\Desktop\\test");
		file.mkdirs();
	}

	@Test
	public void filePath() {
		File file = new File("C:\\3333\\5555\\5.4");
		System.out.println(file.isFile());
		System.out.println(file.getName());
		System.out.println(file.getAbsolutePath());
		System.out.println(file.getParent());
		System.out.println(file.getPath());
	}
	
	@Test
	public void Templete() {
		try {
			Engine engine = new Engine();
			engine.doInBackground(System.out);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
