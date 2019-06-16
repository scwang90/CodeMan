package ${packageName}.exception;

import ${packageName}.constant.ResultCode;
import ${packageName}.model.api.ApiResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.validation.BindException;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.NoHandlerFoundException;
import java.util.*;
import javax.servlet.http.HttpServletRequest;


/**
 * 全局错误异常处理
 * @author ${author}
 * @since ${.now?string("yyyy-MM-dd zzzz")}
 */
@ControllerAdvice
public class GlobalExceptionHandler {

    private Logger logger = LoggerFactory.getLogger(getClass());

    /**
    * 系统异常处理，比如：404,500
    */
    @ResponseBody
    public ApiResult defaultErrorHandler(HttpServletRequest req, Exception e) {
        logger.debug("handler-" + e.getMessage());
        if (e instanceof NoHandlerFoundException) {
            return new ApiResult<>(((NoHandlerFoundException) e).getRequestURL(), ResultCode.C404.code, ResultCode.C404.remark);
        } else if (e instanceof BindException) {
            return validateMessage(((BindException) e).getBindingResult());
        } else if (e instanceof ServiceException) {
            return ApiResult.failure400(e.getMessage());
        } else {
            return ApiResult.failure500(e.getMessage());
        }
    }


    private ApiResult validateMessage(BindingResult binder) {
        Map<String, String> errors = new HashMap<>();
        ApiResult result = new ApiResult<>(errors, ResultCode.C400.code, ResultCode.C400.remark);
        for (ObjectError objectError : binder.getAllErrors()) {
            if (objectError instanceof FieldError) {
                errors.put(((FieldError) objectError).getField(), objectError.getDefaultMessage() + "");
            } else {
                errors.put(objectError.getObjectName(), objectError.getDefaultMessage() + "");
            }
        }
        return result;
    }

}

