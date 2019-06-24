package ${packageName}.annotations;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * Sql方法申明，在DaoImpl使用
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.METHOD})
public @interface Sql {
	String value();
}
