package ${packageName}.controller

import ${packageName}.model.api.ApiResult
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.module.kotlin.readValue
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.autoconfigure.web.ErrorProperties
import org.springframework.boot.autoconfigure.web.servlet.error.BasicErrorController
import org.springframework.boot.web.servlet.error.DefaultErrorAttributes
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity
import org.springframework.stereotype.Controller
import springfox.documentation.annotations.ApiIgnore
import javax.servlet.http.HttpServletRequest

/**
 * 统一错误返回格式
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@ApiIgnore
@Controller
class ErrorController : BasicErrorController(DefaultErrorAttributes(), ErrorProperties()) {

    @Autowired
    private lateinit var mapper: ObjectMapper

    override fun error(request: HttpServletRequest?): ResponseEntity<Map<String, Any>> {
        val status = getStatus(request)
        val body = getErrorAttributes(request, isIncludeStackTrace(request, MediaType.ALL))
        val result = ApiResult(null, status.value(), "${r'${body["error"]}-${body["message"]}'}")
        return ResponseEntity(mapper.readValue<Map<String, Any>>(mapper.writeValueAsString(result)), status)
    }

}