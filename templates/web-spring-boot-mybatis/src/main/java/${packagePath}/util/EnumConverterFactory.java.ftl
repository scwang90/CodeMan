package ${packageName}.util;

import org.springframework.core.convert.converter.Converter;
import org.springframework.core.convert.converter.ConverterFactory;

import java.util.HashMap;
import java.util.Map;
import java.util.WeakHashMap;

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
 
    class EnumConverter<T extends Enum> implements Converter<String, T> {
        private Map<String, T> enumMap = new HashMap<>();
 
        EnumConverter(Class<T> enumType) {
            T[] enums = enumType.getEnumConstants();
            for(T e : enums) {
                enumMap.put(e.ordinal() + "", e);
            }
        }

        @Override
        public T convert(String source) {
            T result = enumMap.get(source);
            if(result == null) {
                throw new IllegalArgumentException("无效枚举值：" + source);
            }
            return result;
        }
    }
}