package ${packagename}.aspect;

import static java.lang.System.out;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;

import com.datastatistics.util.JacksonUtil;

import ${packagename}.util.JacksonUtil;

/**
 * 日志处理切面
 * @author ${author}
 * @date ${.now?string("yyyy-MM-dd HH:mm:ss zzzz")} 
 */
@Aspect
public class LoggingAspect {
	
	public void before(JoinPoint point) {
		out.print(LoggingAspect.class.getSimpleName()+"-");
		out.print(point.getTarget().getClass().getSimpleName()+".");
		out.print(point.getSignature().getName()+"-begin-args-");
		try {
			out.print(JacksonUtil.toJson(point.getArgs()));
		} catch (Throwable e) {
			// TODO: handle exception
			out.print("[");
			for (Object object : point.getArgs()) {
				out.print(object.toString()+",");
			}
			out.print("\b]");
		}
		out.println();
	}
	
	public void after(JoinPoint point) {
		out.print(LoggingAspect.class.getSimpleName()+"-");
		out.print(point.getTarget().getClass().getSimpleName()+".");
		out.print(point.getSignature().getName()+"-after-");
		out.println();
	}
	
	public void returned(JoinPoint point,Object result) {
		out.print(LoggingAspect.class.getSimpleName()+"-");
		out.print(point.getTarget().getClass().getSimpleName()+".");
		out.print(point.getSignature().getName()+"-returned-result-");
		out.print((result instanceof String)?result:JacksonUtil.toJson(result));
		out.println();
	}
	
	public void throwed(JoinPoint point,Throwable ex) {
		out.print(LoggingAspect.class.getSimpleName()+"-");
		out.print(point.getTarget().getClass().getSimpleName()+".");
		out.print(point.getSignature().getName()+"-throwed-ex-");
		out.print(ex.getMessage()+"-"+ex.getClass().getSimpleName());
		out.println();
	}

}
