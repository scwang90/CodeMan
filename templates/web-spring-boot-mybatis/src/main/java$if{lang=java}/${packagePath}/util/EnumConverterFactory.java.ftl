package ${packageName}.util;

import ${packageName}.exception.ClientException;

import org.springframework.core.convert.converter.Converter;
import org.springframework.core.convert.converter.ConverterFactory;

import java.util.HashMap;
import java.util.Map;
import java.util.WeakHashMap;

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
 * public class ProjectApplication implements WebMvcConfigurer {
 *     @Override
 *     public void addFormatters(FormatterRegistry registry) {
 *         registry.addConverterFactory(new EnumConverterFactory());
 *     }
 * }
 *
 * 由代码生成器生成，可以修改
 * 但是如果删除，下次继续生成时，又会出现
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public class EnumConverterFactory implements ConverterFactory<String, Enum> {
 
    private static final Map<Class, Converter> converterMap = new WeakHashMap<>();
 
    @Override
    public <T extends Enum> Converter<String, T> getConverter(Class<T> targetType) {
        //noinspection unchecked
        Converter<String, T> result = converterMap.get(targetType);
        if(result == null) {
            result = new EnumConverter<>(targetType);
            converterMap.put(targetType, result);
        }
        return result;
    }

    static class EnumConverter<T extends Enum> implements Converter<String, T> {
        private final Map<String, T> enumMap = new HashMap<>();
 
        EnumConverter(Class<T> enumType) {
            T[] enums = enumType.getEnumConstants();
            for(T e : enums) {
                enumMap.put(e.ordinal() + "", e);
                enumMap.put(e.toString() + "", e);
            }
        }

        @Override
        public T convert(String source) {
            T result = enumMap.get(source);
            if(result == null) {
                throw new ClientException("无效枚举值：" + source);
            }
            return result;
        }
    }
}