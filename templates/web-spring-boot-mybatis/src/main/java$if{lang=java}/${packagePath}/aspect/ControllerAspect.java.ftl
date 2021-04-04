package ${packageName}.aspect;

import ${packageName}.exception.ClientException;
import ${packageName}.model.api.ApiResult;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

/**
 * Controller 数据异常处理切面
 * 目前主要处理客户点异常，转换为普通的错误消息
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Slf4j
@Aspect
@Component
public class ControllerAspect {

	@Around("execution(public ${packageName}.model.api.ApiResult ${packageName}.controller..*.*(..))")
	public Object around(ProceedingJoinPoint point) throws Throwable {
		try {
			return point.proceed();
		} catch (ClientException e) {
			log.warn(e.getMessage());
			return ApiResult.failure400(e.getMessage());
		}
	}

}
