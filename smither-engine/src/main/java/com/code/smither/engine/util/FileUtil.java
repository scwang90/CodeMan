package com.code.smither.engine.util;

import java.io.*;
import java.util.Locale;

public class FileUtil {

	private static String[] FILE_EXTENSIONS_TEXT = new String[]{
			".ftl", ".txt",
			".ini", ".iml", ".properties", ".gradle", ".cfg", ".gitignore",
			".html", ".jsp", ".asp", ".js", ".css",
			".xaml",
			".bat", ".sh",
			".xml", ".json",
			".java", ".cs", ".groovy", ".kt", ".kts", ".c", ".cpp", ".h",
	};

	private static String[] FILE_EXTENSIONS_BIN = new String[]{
			".exe", ".jar", ".apk",
			".class", ".o",
			".zip", ".rar", ".7z", ".tar", ".war"
	};

	public static boolean isTextFile(File file){
		String name = file.getName().toLowerCase(Locale.ENGLISH);
		for (String text : FILE_EXTENSIONS_TEXT) {
			if (name.endsWith(text) && file.length() < 1024*1024) {
				return true;
			}
		}
		for (String text : FILE_EXTENSIONS_BIN) {
			if (name.endsWith(text)) {
				return false;
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
