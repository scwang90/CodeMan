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

	public static String camelReverse(String origin, String division) {
		StringBuilder builder = new StringBuilder();
		for (int i = 0, lc = 0; i < origin.length(); i++) {
			char c = origin.charAt(i);
			if (c > 0x40 && lc > c && (c & 0x20) != (lc & 0x20)) {
				builder.append(division);
			}
			if (c < 0x40) {
				builder.append(c);
			} else {
				builder.append((char) (c & ~0b00100000));
			}
			lc = c;
		}
		return builder.toString();
	}

	public static boolean isNullOrBlank(String remark) {
		if (remark == null) {
			return true;
		}
		if (remark.length() == 0) {
			return true;
		}
		return remark.trim().length() == 0;
	}

	public static boolean equals(CharSequence a, CharSequence b) {
		if (a == b) return true;
		int length;
		if (a != null && b != null && (length = a.length()) == b.length()) {
			if (a instanceof String && b instanceof String) {
				return a.equals(b);
			} else {
				for (int i = 0; i < length; i++) {
					if (a.charAt(i) != b.charAt(i)) return false;
				}
				return true;
			}
		}
		return false;
	}
}
