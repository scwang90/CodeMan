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
 * 自定义枚举识别注解
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Documented
@Constraint(validatedBy = {
        EnumValue.EnumValueValidator.class,
        EnumValue.EnumValueValidatorInt.class,
        EnumValue.EnumValueValidatorShort.class
})
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.METHOD, ElementType.FIELD, ElementType.ANNOTATION_TYPE, ElementType.CONSTRUCTOR, ElementType.PARAMETER})
public @interface EnumValue {
    // 默认错误消息
    String message() default "无效的枚举值";

    boolean required() default false;

    // 约束注解在验证时所属的组别
    Class<?>[] groups() default {};

    // 约束注解的有效负载
    Class<? extends Payload>[] payload() default {};

    Class<? extends Enum> value() default Enum.class;

    // 同时指定多个时使用
    @Target({ElementType.METHOD, ElementType.FIELD, ElementType.ANNOTATION_TYPE, ElementType.CONSTRUCTOR, ElementType.PARAMETER})
    @Documented
    @Retention(RetentionPolicy.RUNTIME)
    @interface List {
        EnumValue[] value();
    }

    class EnumValueValidatorInt implements ConstraintValidator<EnumValue, Integer> {

        private int length = 0;
        private boolean required;

        //这个方法做一些初始化校验
        public void initialize(EnumValue annotation) {
            required = annotation.required();
            length = annotation.value().getEnumConstants().length;
        }

        // 这个方法写具体的校验逻辑：校验数字是否属于指定枚举类型的范围
        public boolean isValid(Integer value, ConstraintValidatorContext context) {
            if (value == null) {
                return !required;
            }
            return value >= 0 && value < length;
        }
    }

    class EnumValueValidatorShort implements ConstraintValidator<EnumValue, Short> {

        private int length = 0;
        private boolean required;

        //这个方法做一些初始化校验
        public void initialize(EnumValue annotation) {
            required = annotation.required();
            length = annotation.value().getEnumConstants().length;
        }

        // 这个方法写具体的校验逻辑：校验数字是否属于指定枚举类型的范围
        public boolean isValid(Short value, ConstraintValidatorContext context) {
            if (value == null) {
                return !required;
            }
            return value >= 0 && value < length;
        }
    }

    class EnumValueValidator implements ConstraintValidator<EnumValue, Enum> {

        private boolean required;
        //这个方法做一些初始化校验
        public void initialize(EnumValue constraintAnnotation) {
            required = constraintAnnotation.required();
        }
        // 这个方法写具体的校验逻辑：校验数字是否属于指定枚举类型的范围
        public boolean isValid(Enum value, ConstraintValidatorContext context) {
            return !required || value != null;
        }

    }
}