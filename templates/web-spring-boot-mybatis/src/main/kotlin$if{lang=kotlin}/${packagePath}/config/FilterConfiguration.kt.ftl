package ${packageName}.config

import com.fasterxml.jackson.databind.JsonNode
import com.fasterxml.jackson.databind.ObjectMapper
import org.apache.catalina.connector.CoyoteInputStream
import org.apache.catalina.connector.InputBuffer
import org.apache.coyote.Request
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.web.servlet.FilterRegistrationBean
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.http.MediaType
import java.nio.ByteBuffer
import java.nio.charset.StandardCharsets
import java.util.*
import javax.servlet.*
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletRequestWrapper
import kotlin.streams.toList

/**
 * 配置类 - 注入过滤器
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Configuration
class FilterConfiguration {

    /**
     * JSON 参数过滤器，可以支持吧客户端发送的Json数据以Query或者Form方式接受
     */
    @Bean
    fun jsonParamFilterBean(@Autowired jackson: ObjectMapper):FilterRegistrationBean<*> {
        val bean = FilterRegistrationBean<Filter>()
        bean.order = 1
        bean.setName("jsonParamFilter")
        bean.addUrlPatterns("/api/*")
        bean.filter = JsonParamFilter(jackson)
        return bean
    }

    /**
    * Json参数解析过滤器
    * 过滤器可以让 表单参数也可以接收 Json 请求
    */
    class JsonParamFilter (val jackson: ObjectMapper) : Filter {

        companion object {
            val log: Logger = LoggerFactory.getLogger(JsonParamFilter::class.java)
        }

        private class JsonParamHttpRequest(request: HttpServletRequest,val stream: ServletInputStream,val node: JsonNode) : HttpServletRequestWrapper(request) {

            private var names: Enumeration<String>? = null
            private var map: Map<String, Array<String>?>? = null

            override fun getInputStream(): ServletInputStream {
                return stream
            }

            override fun getParameterMap(): Map<String, Array<String>?>? {
                if (map == null) {
                    map = parameterNames?.asSequence()?.map { it to getParameterValues(it) }?.toMap()
                }
                return map
            }

            override fun getParameterNames(): Enumeration<String>? {
                this.names?.also { return it }
                this.node.fieldNames()?.asSequence()?.toMutableList()?.run {
                    super.getParameterNames()?.let { addAll(it.toList()) }
                    return Collections.enumeration(this).apply { names = this }
                }
                return super.getParameterNames()
            }

            override fun getParameter(name: String): String? {
                node.get(name)?.run {
                    return getParameterValues(name).let { array->
                        if (array != null && array.isNotEmpty()) array.joinToString(",") else null
                    }
                }
                return super.getParameter(name)
            }

            override fun getParameterValues(name: String): Array<String>? {
                node.get(name)?.run {
                    return if (isArray) { map { valueFromNode(it) }.toTypedArray() } else arrayOf(valueFromNode(this))
                }
                return super.getParameterValues(name)
            }

            private fun valueFromNode(value: JsonNode): String {
                return when {
                    value.isNull ->  ""
                    value.isTextual -> value.textValue()
                    value.isArray -> value.joinToString(",") { valueFromNode(it) }
                    else ->  value.toPrettyString()
                }
            }

        }

        override fun doFilter(request: ServletRequest, response: ServletResponse, chain: FilterChain) {
            var useRequest: ServletRequest = request
            if (request is HttpServletRequest && request.contentLength > 0) {
                val contentType = request.contentType ?: ""
                if (contentType.startsWith(MediaType.APPLICATION_JSON_VALUE, false)) {
                    val mediaType = MediaType.parseMediaType(contentType)
                    val charset = mediaType.charset ?: StandardCharsets.UTF_8
                    val reader = request.inputStream.bufferedReader(charset)
                    val json = reader.lines().toList().joinToString("")
                    val input = InputBuffer(32).apply { byteBuffer = ByteBuffer.wrap(json.toByteArray(charset));setRequest(Request()) }
                    useRequest = JsonParamHttpRequest(request, object : CoyoteInputStream(input) {  }, jackson.readTree(json))
                }
            }
            chain.doFilter(useRequest, response)
        }
    }
}