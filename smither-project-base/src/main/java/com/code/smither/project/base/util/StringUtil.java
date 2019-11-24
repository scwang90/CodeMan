package com.code.smither.project.base.util;

@SuppressWarnings("unused")
public class StringUtil {
	
	/**
	 * 大写第一个字母
	 */
	public static String upperFirst(String s) {
		if (s == null || s.length() == 0) {
			return s;
		}
		StringBuffer sb = new StringBuffer();
		sb.append(s.substring(0, 1).toUpperCase());
		sb.append(s.substring(1, s.length()));
		return sb.toString();
	}

	/**
	 * 小写第一个字母
	 */
	public static String lowerFirst(String s) {
		if (s == null || s.length() == 0) {
			return s;
		}
		StringBuffer sb = new StringBuffer();
		sb.append(s.substring(0, 1).toLowerCase());
		sb.append(s.substring(1, s.length()));
		return sb.toString();
	}


	public static String camel(String origin, String division) {
		if (division != null && division.length() > 0) {
			String[] divs = origin.split(division);
			StringBuilder originBuilder = new StringBuilder();
			for (String div : divs) {
				String lower = div.matches("^[A-Z0-9]+$") ? div.toLowerCase() : div;
				originBuilder.append(upperFirst(lower));
			}
			origin = originBuilder.toString();
		}
		return origin;
	}

}
