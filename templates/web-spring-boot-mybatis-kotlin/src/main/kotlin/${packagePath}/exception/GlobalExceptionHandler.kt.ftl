package ${packageName}.exception

import ${packageName}.constant.ResultCode
import ${packageName}.model.api.ApiResult
import org.slf4j.LoggerFactory
import org.springframework.validation.BindException
import org.springframework.validation.BindingResult
import org.springframework.validation.FieldError
import org.springframework.validation.ObjectError
import org.springframework.web.bind.annotation.ControllerAdvice
import org.springframework.web.bind.annotation.ExceptionHandler
import org.springframework.web.bind.annotation.ResponseBody
import org.springframework.web.servlet.NoHandlerFoundException
import java.util.*
import javax.servlet.http.HttpServletRequest

/**
 * 全局错误异常处理
 * @author ${author}
 * @since ${.now?string("yyyy-MM-dd zzzz")}
 */
@ControllerAdvice
class GlobalExceptionHandler {

    private val logger = LoggerFactory.getLogger(javaClass)

    /**
     * 系统异常处理，比如：404,500
     * @param req
     * @param e
     */
    @ResponseBody
    @ExceptionHandler(value = [Throwable::class])
    fun defaultErrorHandler(req: HttpServletRequest, e: Exception): ApiResult<*> {
        logger.debug("handler-" + e.message)
        return when (e) {
            is NoHandlerFoundException -> ApiResult(e.requestURL, ResultCode.C404.code, ResultCode.C404.remark)
            is BindException -> validateMessage(e.bindingResult)
            is ServiceException -> ApiResult.failure400(e.message)
            else -> ApiResult.failure500(e.message)
        }
    }


    protected fun validateMessage(binder: BindingResult): ApiResult<*> {
        val errors = HashMap<String, String>()
        val result = ApiResult(errors, ResultCode.C400.code, ResultCode.C400.remark)
        val objectErrors = binder.allErrors
        val it = objectErrors.iterator()
        while (it.hasNext()) {
            val objectError = it.next() as ObjectError
            if (objectError is FieldError) {
                errors[objectError.field] = objectError.defaultMessage ?: ""
            } else {
                errors[objectError.objectName] = objectError.defaultMessage ?: ""
            }
        }
        return result

    }
}
