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
 * 自定义验证注解 - 手机号码
 *
 * 由代码生成器生成，可以修改
 * 但是如果删除，下次继续生成时，又会出现
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Documented
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = {PhoneValue.ValueValidator.class})
@Target({ElementType.FIELD, ElementType.CONSTRUCTOR, ElementType.PARAMETER})
public @interface PhoneValue {

    // 默认错误消息
    String message() default "无效的手机号码";

    boolean noblank() default true;
    boolean required() default false;

    // 约束注解在验证时所属的组别
    Class<?>[] groups() default {};

    // 约束注解的有效负载
    Class<? extends Payload>[] payload() default {};

    Class<? extends Enum> value() default Enum.class;

    class ValueValidator implements ConstraintValidator<PhoneValue, String> {

        private PhoneValue annotation;
        //这个方法做一些初始化校验
        @Override
        public void initialize(PhoneValue constraintAnnotation) {
            annotation = constraintAnnotation;
        }

        @Override
        public boolean isValid(String value, ConstraintValidatorContext constraintValidatorContext) {
            if (annotation.required() && value == null) {
                return false;
            }
            if (annotation.noblank() && value.length() == 0) {
                return false;
            }
            if (value != null && value.length() > 0) {
                return value.matches("^1\\d{10}$");
            }
            return true;
        }

    }
}