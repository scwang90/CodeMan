package ${packageName}.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 通用API标记注解
 * @author ${author}
 * @since ${.now?string("yyyy-MM-dd zzzz")}
 */
@Target({ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
public @interface CommonApi {
}
