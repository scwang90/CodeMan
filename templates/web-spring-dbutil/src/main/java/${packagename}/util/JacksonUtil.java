// Copyright (c) 2003-2013, LogMeIn, Inc. All rights reserved.
package ${packagename}.util;

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
 * Helper class for parsing to and from json for API calls
 * @author ${author}
 * @date ${.now?string("yyyy-MM-dd HH:mm:ss zzzz")}
 */
public class JacksonUtil {

	private static ObjectMapper objectMapper;

	/**
	 * Get the list of model objects and create json as expected by the API.
	 * @param model models to be parsed to body
	 * @return json string suitable for Xively API consumption
	 */
	public static  String toJson(Object model) {
		try {
			return getObjectMapper().writeValueAsString(model);
		} catch (IOException e) {
			throw new RuntimeException("JacksonUtil.toJson",e);
		}
	}

	public static <T> List<T> toObjects(
			String body, Class<T> clazz){
		try {
			CollectionType collectionType = TypeFactory.defaultInstance()
					.constructCollectionType(ArrayList.class, clazz);
			return getObjectMapper().readValue(body, collectionType);
		} catch (IOException e) {
			throw new RuntimeException("JacksonUtil.toObjects", e);
		}
	}

	public static <T> T toObject(String body,
								 Class<T> clazz) {
		try {
			return getObjectMapper().readValue(body, clazz);
		} catch (IOException e) {
			throw new RuntimeException("JacksonUtil.toObject", e);
		}
	}

	public static ObjectMapper getObjectMapper() {
		if (objectMapper == null) {
			ObjectMapper mapper = new ObjectMapper();
			mapper.configure(DeserializationFeature.ACCEPT_SINGLE_VALUE_AS_ARRAY, true);
			mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
			mapper.configure(DeserializationFeature.FAIL_ON_IGNORED_PROPERTIES, false);
			mapper.configure(DeserializationFeature.EAGER_DESERIALIZER_FETCH, false);
			mapper.configure(SerializationFeature.EAGER_SERIALIZER_FETCH, false);
			objectMapper = mapper;
		}
		return objectMapper;
	}
}
