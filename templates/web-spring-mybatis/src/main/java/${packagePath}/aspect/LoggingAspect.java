package ${packageName}.aspect;

import ${packageName}.util.JacksonUtil;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;

import javax.servlet.http.HttpServletRequest;

import static java.lang.System.out;

/**
 * 日志处理切面
 * @author ${author}
 * @date ${.now?string("yyyy-MM-dd zzzz")}
 */
@Aspect
public class LoggingAspect {

	public static boolean log = true;

	public void before(JoinPoint point) {
		if (log){
			out.print(LoggingAspect.class.getSimpleName()+"-");
			out.print(point.getTarget().getClass().getSimpleName()+".");
			out.print(point.getSignature().getName() + "-begin-args-");
			Object[] args = point.getArgs();
			if (args != null && args.length > 0){
				out.print("([");
				for (Object object : point.getArgs()) {
					try {
						out.print(JacksonUtil.toJson(object)+",");
					} catch (Throwable e) {
						if (object instanceof HttpServletRequest) {
							HttpServletRequest request = (HttpServletRequest) object;
							out.print("{"+request.getQueryString()+","+JacksonUtil.toJsonNoException(request.getCookies())+"},");
						} else {
							out.print(object+",");
						}
					}
				}
				out.print("\b])");
			} else {
				out.print("()");
			}
			out.println();
		}
	}

	public void after(JoinPoint point) {
		if (log){
			out.print(LoggingAspect.class.getSimpleName()+"-");
			out.print(point.getTarget().getClass().getSimpleName()+".");
			out.print(point.getSignature().getName()+"-after-");
			out.println();
		}
	}

	public void returned(JoinPoint point,Object result) {
		if (log){
			out.print(LoggingAspect.class.getSimpleName()+"-");
			out.print(point.getTarget().getClass().getSimpleName()+".");
			out.print(point.getSignature().getName()+"-returned-result-");
			out.print((result instanceof String)?result:JacksonUtil.toJsonNoException(result));
			out.println();
		}
	}

	public void throwed(JoinPoint point,Throwable ex) {
		if (log){
			out.print(LoggingAspect.class.getSimpleName()+"-");
			out.print(point.getTarget().getClass().getSimpleName()+".");
			out.print(point.getSignature().getName()+"-throwed-ex-");
			out.print(ex.getMessage()+"-"+ex.getClass().getSimpleName());
			out.println();
			ex.printStackTrace(out);
		}
	}

}
