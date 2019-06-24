package ${packageName}.annotations;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 必须参数标记
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Target( { ElementType.FIELD })
@Retention(RetentionPolicy.RUNTIME)
public @interface Must {
    String value() default "";
}
