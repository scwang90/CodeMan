package ${packageName}.util

import com.fasterxml.jackson.annotation.JsonInclude
import com.fasterxml.jackson.databind.ObjectMapper
import org.apache.commons.beanutils.BeanUtils

/**
 * 对象工具类
 * 目前主要功能对象属性拷贝（忽略空字段）
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
object BeanUtils {

    private val mapper = ObjectMapper().apply { setSerializationInclusion(JsonInclude.Include.NON_NULL) }

    fun <T> copyProperties(source: Any, dest: T): T {
        val json = mapper.writeValueAsString(source)
        val map = mapper.readValue(json, java.util.Map::class.java)
        BeanUtils.copyProperties(dest, map)
        return dest
    }
}