package ${packageName}.annotations.dbmodel;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 数据库忽略字段
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Target( { ElementType.FIELD })
@Retention(RetentionPolicy.RUNTIME)
public @interface DbIgnore {

}
