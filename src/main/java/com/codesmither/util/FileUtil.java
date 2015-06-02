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
		String name = file.getName().toLowerCase(Locale.ENGLISH);
		return name.endsWith(".java") ||name.endsWith(".xml") ||
				name.endsWith(".ftl") ||name.endsWith(".properties");
	}
}
