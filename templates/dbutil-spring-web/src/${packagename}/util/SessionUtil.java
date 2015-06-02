package ${packagename}.util;

/**
 * 获取Session
 * @Author SCWANG
 */
public class SessionUtil {

//	/**
//	 * 获取当前登陆用户
//	 * @param request
//	 * @return
//	 */
//	public static Sysuser getUser(HttpServletRequest request) {
//		HttpSession session = request.getSession();
//		Object sysuser = session.getAttribute("sysuser");
//		if (sysuser instanceof Sysuser) {
//			return Sysuser.class.cast(sysuser);
//		}
//		return null;
//	}
//
//	/**
//	 * 存入登陆用户
//	 * @param request
//	 * @param sysuser
//	 */
//	public static void setUser(HttpServletRequest request, Sysuser sysuser) {
//		// TODO Auto-generated method stub
//		request.getSession().setAttribute("sysuser", sysuser);
//	}
}
