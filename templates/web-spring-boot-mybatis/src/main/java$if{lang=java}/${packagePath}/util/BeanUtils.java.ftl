package ${packageName}.util;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.lang.reflect.InvocationTargetException;
import java.util.Map;

/**
 * 对象工具类
 * 目前主要功能对象属性拷贝（忽略空字段）
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public class BeanUtils {

    private static final ObjectMapper mapper = new ObjectMapper();

    static {
        mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
    }

    //public static <T> T copyProperties(Object source, T dest) throws JsonProcessingException, InvocationTargetException, IllegalAccessException {
    //    Map<?,?> map = mapper.readValue(mapper.writeValueAsString(source), Map.class);
    //    org.apache.commons.beanutils.BeanUtils.copyProperties(dest, map);
    //    return dest;
    //}

}
