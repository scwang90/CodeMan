package ${packageName}.controller

package ${packageName}.controller

import ${packageName}.exception.ClientException
import ${packageName}.exception.CodeException
import ${packageName}.model.api.ApiResult
import ${packageName}.model.conf.AppConfig

import com.fasterxml.jackson.databind.ObjectMapper
import com.github.pagehelper.util.StringUtil
import org.apache.tomcat.util.http.fileupload.impl.FileSizeLimitExceededException
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.ObjectProvider
import org.springframework.boot.autoconfigure.web.ServerProperties
import org.springframework.boot.autoconfigure.web.servlet.error.BasicErrorController
import org.springframework.boot.autoconfigure.web.servlet.error.ErrorViewResolver
import org.springframework.boot.web.servlet.error.ErrorAttributes
import org.springframework.http.HttpStatus
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity
import org.springframework.util.unit.DataSize
import org.springframework.validation.BindException
import org.springframework.web.bind.annotation.ExceptionHandler
import org.springframework.web.bind.annotation.RestControllerAdvice
import org.springframework.web.context.request.ServletWebRequest
import java.sql.SQLTransientConnectionException
import java.util.*
import javax.servlet.http.HttpServletRequest
import javax.validation.ConstraintViolationException
import javax.validation.ValidationException

/**
 * 统一错误返回格式
 * 支持-区分服务器异常、客户端异常
 * 支持-配置是否返回原始错误信息
 * @author 树朾
 * @since 2021-03-03 中国标准时间
 */
@RestControllerAdvice
class ErrorController(
    private var config: AppConfig,
    private val mapper: ObjectMapper,
    private val error: ErrorAttributes,
    server: ServerProperties,
    errorView: ObjectProvider<ErrorViewResolver>)
    : BasicErrorController(error, server.error, errorView.toList()) {

    companion object {
        val logger: Logger = LoggerFactory.getLogger(ErrorController::class.java)
    }

    @ExceptionHandler(CodeException::class)
    fun handle(ex: CodeException): ApiResult<Any> {
        var message = ex.message ?: ""
        if (ex is ClientException) {
            logger.debug(ex.message)
        } else {
            if (!config.error.original) {
                message = "服务器内部错误"
            }
            logger.error(ex.message, ex)
        }
        return ApiResult.fail(ex.code, message)
    }


    @ExceptionHandler(BindException::class)
    fun handler(ex: BindException): ApiResult<Any> {
        logger.debug(ex.message)
        var message = "参数验证错误"
        val messages: MutableList<String> = LinkedList()
        if (ex.hasGlobalErrors()) {
            for (error in ex.globalErrors) {
                message = "$message\n${error.objectName}:${error.defaultMessage}"
                messages.add("${error.objectName}:${error.defaultMessage}")
            }
        }
        if (ex.hasFieldErrors()) {
            for (error in ex.fieldErrors) {
                message = "$message\n${error.field}:${error.defaultMessage}"
                messages.add("${error.objectName}:${error.field}:${error.defaultMessage}")
            }
        }
        //errors = messages
        return ApiResult.fail(HttpStatus.BAD_REQUEST.value(), message)
    }

    @ExceptionHandler(ValidationException::class)
    fun handler(ex: ValidationException): ApiResult<Any> {
        logger.debug(ex.message)
        var message = "参数验证错误"
        if (ex is ConstraintViolationException) {
            val messages: MutableList<String> = LinkedList()
            for (constraint in ex.constraintViolations) {
                message = "$message\n${constraint.propertyPath}:${constraint.message}"
                messages.add("${constraint.propertyPath}:${constraint.message}")
            }
            //errors = messages
        }
        return ApiResult.fail(HttpStatus.BAD_REQUEST.value(), message)
    }

    override fun error(request: HttpServletRequest): ResponseEntity<Map<String, Any?>> {
        val status = getStatus(request).value()
        var httpStatus: HttpStatus = HttpStatus.OK
        var body: Map<String, Any?> = getErrorAttributes(request, getErrorAttributeOptions(request, MediaType.ALL))
        if (body["path"]?.toString()?.startsWith("/api") != true) {
            return super.error(request)
        }

        var message = "${body["error"]}"
        body["message"]?.also { msg->
            if (StringUtil.isNotEmpty("$msg")) {
                message = "$message - msg"
            }
        }
        val errors = body["errors"]
        val error: Throwable? = error.getError(ServletWebRequest(request))
        var cause = error
        while (cause?.cause != null && cause.cause != cause) {
            message += " <- " + cause.message
            cause = cause.cause
        }
        if (!config.original && error != null) {
            message = "服务器内部错误"
        } else if (cause is SQLTransientConnectionException) {
            message = "连接数据库异常：" + cause.message
        } else if (cause is FileSizeLimitExceededException) {
            val e = cause
            httpStatus = getStatus(request)
            message = String.format("文件[%s]不能超过[%dMB]", e.fileName, DataSize.ofBytes(e.permittedSize).toMegabytes())
        } else {
            cause?.also {
                message += " <- "
                message += it.message
            }
        }
        try {
            val result = ApiResult(status, message, null)

            val mutable = mutableMapOf<String, Any?>();
            val map = mapper.readValue(mapper.writeValueAsString(result), MutableMap::class.java)
            for (entry in map) {
                mutable[entry.key?.toString()?:""] = entry.value
            }
            errors?.also {
                mutable["errors"] = it
            }
            body = mutable;
        } catch (e: Exception) {
            httpStatus = HttpStatus.INTERNAL_SERVER_ERROR
        }
        return ResponseEntity(body, httpStatus)
    }
}