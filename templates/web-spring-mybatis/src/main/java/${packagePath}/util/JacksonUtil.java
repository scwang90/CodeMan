package ${packageName}.util;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.databind.type.CollectionType;
import com.fasterxml.jackson.databind.type.TypeFactory;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Jackson工具类
 *
 * @author 树朾
 * @since 2015-11-02 17:16:40 中国标准时间
 */
public class JacksonUtil {

	private static ObjectMapper objectMapper;

	/**
	 * 将对象转成Jsong字符串
	 */
	public static String toJson(Object model) throws JsonProcessingException {
		return getObjectMapper().writeValueAsString(model);
	}

	/**
	 * 将对象转成Jsong字符串
	 * 失败时候不会抛出异常-但是会返回null
	 */
	public static String toJsonNoException(Object model) {
		try {
			return getObjectMapper().writeValueAsString(model);
		} catch (JsonProcessingException e) {
			return null;
		}
	}

	/**
	 * 将 Json 饭序列化成 List 对象
	 *
	 * @param body  Json
	 * @param clazz 类
	 * @return 不为空的 List 可能 size=0
	 * @throws IOException
	 */
	public static <T> List<T> toObjects(String body, Class<T> clazz) throws IOException {
		List<T> objs;
		CollectionType collectionType = TypeFactory.defaultInstance()
				.constructCollectionType(ArrayList.class, clazz);
		objs = getObjectMapper().readValue(body, collectionType);
		return objs;
	}

	/**
	 * 将 Json 饭序列化成 List 对象
	 * 失败时候不会抛出异常-但是会返回null
	 *
	 * @param body  Json
	 * @param clazz 类
	 * @return 失败时 返回 null
	 */
	public static <T> List<T> toObjectsNoException(String body, Class<T> clazz) {

		List<T> objs;
		CollectionType collectionType = TypeFactory.defaultInstance()
				.constructCollectionType(ArrayList.class, clazz);
		try {
			objs = getObjectMapper().readValue(body, collectionType);
		} catch (Exception e) {
			return null;
		}

		return objs;
	}

	/**
	 * 将 Json 饭序列化成 clazz 对象
	 *
	 * @param body  Json
	 * @param clazz 类
	 * @throws IOException
	 */
	public static <T> T toObject(String body, Class<T> clazz) throws IOException {
		return getObjectMapper().readValue(body, clazz);
	}

	/**
	 * 将 Json 饭序列化成 clazz 对象
	 *
	 * @param body  Json
	 * @param clazz 类
	 * @return 失败时 返回 null
	 */
	public static <T> T toObjectNoException(String body,
											Class<T> clazz) {
		try {
			return getObjectMapper().readValue(body, clazz);
		} catch (IOException e) {
			return null;
		}
	}

	public static ObjectMapper getObjectMapper() {
		if (objectMapper == null) {
			ObjectMapper retval = new ObjectMapper();
			retval.configure(DeserializationFeature.ACCEPT_SINGLE_VALUE_AS_ARRAY, true);
			retval.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
			retval.configure(DeserializationFeature.FAIL_ON_IGNORED_PROPERTIES, false);
			retval.configure(DeserializationFeature.EAGER_DESERIALIZER_FETCH, false);
			retval.configure(SerializationFeature.EAGER_SERIALIZER_FETCH, false);
			objectMapper = retval;
		}
		return objectMapper;
	}
}
