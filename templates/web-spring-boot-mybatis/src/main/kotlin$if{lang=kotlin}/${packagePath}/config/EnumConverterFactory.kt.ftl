package ${packageName}.config

import ${packageName}.exception.ClientException
import org.springframework.core.convert.converter.Converter
import org.springframework.core.convert.converter.ConverterFactory
import java.util.*

/**
 * 枚举转换工厂
 * 用于API的枚举参数转换，如后台枚举 enum Sex{ man, woman }, 客户端需要传入枚举值，
 * 为了减少参数检查和类型转换我们可以直接把参数类型按如下写法
 * ApiResult createUser(String name, Sex sex)
 * 这个时候客户端可以直接传递 int {0,1} 或者 string {man, woman}
 * Spring 将会自动转换为 Sex 类型的参数，我们直接赋值给 model 即可
 * 如果客户端的类型无效，spring将自动返回 400 错误
 * 要让工厂生效，需要添加配置代码如下：
 * @Configuration
 * class ProjectApplication : WebMvcConfigurer {
 *      override fun addFormatters(registry: FormatterRegistry) {
 *          registry.addConverterFactory(EnumConverterFactory())
 *      }
 * }
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
class EnumConverterFactory : ConverterFactory<String, Enum<*>> {

    companion object {
        private val converterMap: MutableMap<Class<*>, Converter<String, *>> = WeakHashMap()
    }

    override fun <T : Enum<*>> getConverter(targetType: Class<T>): Converter<String, T> {
        @Suppress("UNCHECKED_CAST")
        var result: Converter<String, T>? = converterMap[targetType] as Converter<String, T>?
        if (result == null) {
            result = EnumConverter(targetType)
            converterMap[targetType] = result
        }
        return result
    }

    internal class EnumConverter<T : Enum<*>>(enumType: Class<T>) : Converter<String, T> {
        private val enumMap: MutableMap<String, T> = HashMap()

        override fun convert(source: String): T {
            return enumMap[source] ?: throw ClientException("无效枚举值：$source")
        }

        init {
            val enums = enumType.enumConstants
            for (e in enums) {
                if (e != null) {
                    enumMap[e.toString()] = e
                    enumMap[e.ordinal.toString()] = e
                }
            }
        }
    }
}