package ${packageName}.annotation

import javax.validation.Constraint
import javax.validation.ConstraintValidator
import javax.validation.ConstraintValidatorContext
import javax.validation.Payload
import kotlin.reflect.KClass

/**
 * 自定义验证注解 - ID22
 * 验证参数是否为22位的ID
 * Response findUserById(@ID22Value String id)
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@MustBeDocumented
@Retention(AnnotationRetention.RUNTIME)
@Constraint(validatedBy = [ID22Value.ValueValidator::class])
@Target(AnnotationTarget.FIELD, AnnotationTarget.CONSTRUCTOR, AnnotationTarget.VALUE_PARAMETER)
annotation class ID22Value ( // 默认错误消息
    val message: String = "无效的ID22值", val required: Boolean = false,
    val groups: Array<KClass<*>> = [], val payload: Array<KClass<out Payload>> = []
) {
    class ValueValidator : ConstraintValidator<ID22Value, String> {
        private var required = false

        //这个方法做一些初始化校验
        override fun initialize(constraintAnnotation: ID22Value) {
            required = constraintAnnotation.required
        }

        override fun isValid(value: String?, constraintValidatorContext: ConstraintValidatorContext): Boolean {
            return if (required && value == null) {
                false
            } else value?.matches(Regex("^[\\w\\-+*/=]{22}$")) ?: true
        }
    }
}