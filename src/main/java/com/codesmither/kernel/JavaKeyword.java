package com.codesmither.kernel;

/**
 * Java关键字模拟
 * Created by SCWANG on 2015-07-04.
 */
public class JavaKeyword {
	
	public static final String[] javakeywords = { "abstract", "assert",
			"boolean", "break", "byte", "case", "catch", "char", "class",
			"const", "continue", "default", "do", "double", "else", "enum",
			"extends", "final", "finally", "float", "for", "goto", "if",
			"implements", "import", "instanceof", "int", "interface", "long",
			"native", "new", "package", "private", "protected", "public",
			"return", "strictfp", "short", "static", "super", "switch",
			"synchronized", "this", "throw", "throws", "transient", "try",
			"void", "volatile", "while", };

	public static boolean isJavaKeyword(String value){
		for (String keyword : javakeywords) {
			if (keyword.equals(value)) {
				return true;
			}
		}
		return false;
	}
}
