package ${packageName}.util;

import java.util.regex.Pattern;

/**
 * @Description: 字符串常用工具类
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public class AfStringUtil {

	public static boolean isEmpty(String string) {
		return string == null || string.trim().length() == 0;
	}
	
	public static boolean isNotEmpty(String string) {
		return string != null && string.trim().length() > 0;
	}

	public static boolean isEmpty(String ...string) {
		for (String everyone:string){
			if("".equals(everyone)||null==everyone){
				return false;
			}
		}
		return true;
	}
	public static boolean isEmpty(Object ...objects) {
		for (Object everyone:objects){
			if("".equals(everyone.toString())||null==everyone){
				return false;
			}
		}
		return true;
	}

	public static boolean equals(String l,String r){
		if (l != r) {
			if (l != null || r != null) {
				return l.equals(r);
			}
			return false;
		}
		return true;
	}

	/**
	 * 验证输入的邮箱格式是否符合
	 * 
	 * @param email
	 * @return 是否合法
	 */
	public static boolean emailFormat(String email) {
		String pattern = "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
		return Pattern.compile(pattern).matcher(email).find();
	}
	
}
