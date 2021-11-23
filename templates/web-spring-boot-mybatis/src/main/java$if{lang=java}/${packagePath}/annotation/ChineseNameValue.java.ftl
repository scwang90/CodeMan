package ${packageName}.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import javax.validation.Constraint;
import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import javax.validation.Payload;

/**
 * 自定义验证注解 - 中文姓名
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Documented
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = {ChineseNameValue.ValueValidator.class})
@Target({ElementType.FIELD, ElementType.CONSTRUCTOR, ElementType.PARAMETER})
public @interface ChineseNameValue {

    // 默认错误消息
    String message() default "无效中文姓名";

    boolean required() default false;

    // 约束注解在验证时所属的组别
    Class<?>[] groups() default {};

    // 约束注解的有效负载
    Class<? extends Payload>[] payload() default {};

    Class<? extends Enum> value() default Enum.class;

    class ValueValidator implements ConstraintValidator<ChineseNameValue, String> {

        private boolean required;
        //这个方法做一些初始化校验
        @Override
        public void initialize(ChineseNameValue constraintAnnotation) {
            required = constraintAnnotation.required();
        }

        @Override
        public boolean isValid(String value, ConstraintValidatorContext constraintValidatorContext) {
            if (required && value == null) {
                return false;
            }
            if (value != null) {
                return value.matches("^[\\u4E00-\\u9FA5][\\u4E00-\\u9FA5|·]*[\\u4E00-\\u9FA5]$");
            }
            return true;
        }

    }
}