package com.code.smither.engine.util;

import java.io.*;
import java.util.Locale;

public class FileUtil {

	public static boolean isTextFile(File file){
//		if (file.exists()) {
//			FileTypeMap map = FileTypeMap.getDefaultFileTypeMap();
//			System.out.println(map.getContentType(file)+"-"+file.getAbsolutePath());
//			return map.getContentType(file).equals("text/plain");
//		}
		String[] texts = new String[]{
				".ftl",".txt",
				".ini",".iml",".properties",
				".xml",".html",".jsp",".js",".css",
				".xaml",
				".bat",".sh",
				".java",".cs",".groovy",
				".c",".cpp",".h",
				".gitignore"
		};
		String name = file.getName().toLowerCase(Locale.ENGLISH);
		for (String text : texts) {
			if (name.endsWith(text) && file.length() < 1024*1024) {
				return true;
			}
		}
		return false;
	}

	public static void copyFile(File from, File file) throws IOException {
		FileInputStream inputStream = new FileInputStream(from);
		FileOutputStream outputStream = new FileOutputStream(file);
		byte[] bytes = new byte[inputStream.available()];
		if (inputStream.read(bytes) > 0) {
			outputStream.write(bytes);
		}
		outputStream.close();
		inputStream.close();
		System.gc();
	}
}
