package com.codesmither.util;

import java.io.File;
import java.util.Locale;

public class FileUtil {

	public static boolean isTextFile(File file){
		String[] texts = new String[]{
				".ftl",".java",".xml",".properties",
				".html",".jsp",".js",
				".c",".cpp",".txt",".h",".css",
		};
//		if (file.exists()) {
//			FileTypeMap map = FileTypeMap.getDefaultFileTypeMap();
//			System.out.println(map.getContentType(file)+"-"+file.getAbsolutePath());
//			return map.getContentType(file).equals("text/plain");
//		}
		String name = file.getName().toLowerCase(Locale.ENGLISH);
		for (String text : texts) {
			if (name.endsWith(text)) {
				return true;
			}
		}
		return false;
	}
}
