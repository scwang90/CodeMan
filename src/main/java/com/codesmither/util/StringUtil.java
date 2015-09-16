package com.codesmither.util;

public class StringUtil {
	
	/**
	 * 大写
	 * @param s
	 * @return
	 */
	public static final String upperFirst(String s) {
		int len = s.length();
		if (len <= 0)
			return "";

		StringBuffer sb = new StringBuffer();
		sb.append(s.substring(0, 1).toUpperCase());
		sb.append(s.substring(1, len));
		return sb.toString();
	}

	/**
	 * 小写
	 * 
	 * @param s
	 * @return
	 */
	public static final String lowerFirst(String s) {
		int len = s.length();
		if (len <= 0)
			return "";

		StringBuffer sb = new StringBuffer();
		sb.append(s.substring(0, 1).toLowerCase());
		sb.append(s.substring(1, len));
		return sb.toString();
	}

	public static void main(String[] args) {
		System.out.println("s".toUpperCase());
	}
}
