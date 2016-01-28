package com.codesmither.util;

import java.io.File;
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
			if (name.endsWith(text)) {
				return true;
			}
		}
		return false;
	}
}
