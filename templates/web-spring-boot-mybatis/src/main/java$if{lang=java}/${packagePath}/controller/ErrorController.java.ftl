package ${packageName}.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import ${packageName}.exception.AccessException;
import ${packageName}.exception.ClientException;
import ${packageName}.exception.ServiceException;
import ${packageName}.model.api.ApiResult;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.web.ErrorProperties;
import org.springframework.boot.autoconfigure.web.servlet.error.BasicErrorController;
import org.springframework.boot.web.servlet.error.DefaultErrorAttributes;
import org.springframework.boot.web.servlet.error.ErrorAttributes;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindException;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.context.request.ServletWebRequest;

import java.sql.SQLTransientConnectionException;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;

import springfox.documentation.annotations.ApiIgnore;

/**
 * 统一错误返回格式
 * 支持-区分服务器异常、客户端异常
 * 支持-配置是否返回原始错误信息
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@ApiIgnore
@Controller
public class ErrorController extends BasicErrorController {

    private final ObjectMapper mapper;
    private final ErrorAttributes error;

    @Value("${error.original:false}")
    private boolean original;

    public ErrorController(ObjectMapper mapper) {
        super(new DefaultErrorAttributes(), new ErrorProperties());
        this.mapper = mapper;
        this.error = new DefaultErrorAttributes();
    }

    @Override
    public ResponseEntity<Map<String, Object>> error(HttpServletRequest request) {
        HttpStatus status = getStatus(request);
        Map<String, Object> body = getErrorAttributes(request, isIncludeStackTrace(request, MediaType.ALL));
        String message = body.get("error") + "-" + body.get("message");
        Object errors = body.get("errors");
        Throwable error = this.error.getError(new ServletWebRequest(request));
        Throwable cause = error;
        while (cause != null && cause.getCause() != null && cause.getCause() != cause) {
            cause = cause.getCause();
        }
        if (error instanceof ServiceException) {
            message = error.getMessage();
        } else if (error instanceof AccessException) {
            message = error.getMessage();
            status = HttpStatus.NOT_ACCEPTABLE;
        } else if (error instanceof ClientException) {
            message = error.getMessage();
            status = HttpStatus.BAD_REQUEST;
        } else if (error instanceof ConstraintViolationException) {
            List<String> messages = new LinkedList<>();
            for (ConstraintViolation<?> constraint : ((ConstraintViolationException) error).getConstraintViolations()) {
                message = constraint.getMessageTemplate();
                messages.add(constraint.getPropertyPath() + ":" + message);
            }
            errors = messages;
            status = HttpStatus.BAD_REQUEST;
        } else if (error instanceof MethodArgumentNotValidException) {
            List<String> messages = new LinkedList<>();
            BindingResult result = ((MethodArgumentNotValidException) error).getBindingResult();
            for (FieldError fieldError : result.getFieldErrors()) {
                message = fieldError.getDefaultMessage();
                messages.add(fieldError.getField() + ":" + message);
            }
            message = "参数验证错误，详细信息查看 errors";
            errors = messages;
            status = HttpStatus.EXPECTATION_FAILED;
        } else if (error instanceof BindException) {
            List<String> messages = new LinkedList<>();
            BindingResult result = ((BindException) error).getBindingResult();
            for (FieldError fieldError : result.getFieldErrors()) {
                message = fieldError.getDefaultMessage();
                messages.add(fieldError.getField() + ":" + message);
            }
            message = "参数验证错误，详细信息查看 errors";
            errors = messages;
            status = HttpStatus.EXPECTATION_FAILED;
        } else if (!original && error != null) {
            message = "服务器内部错误";
        } else if (cause instanceof SQLTransientConnectionException) {
            message = "连接数据库异常：" + cause.getMessage();
        }
        try {
            ApiResult<?> result = new ApiResult<>(null, status.value(), message, errors);
            //noinspection unchecked
            Map<String, Object> map = mapper.readValue(mapper.writeValueAsString(result), Map.class);
            return new ResponseEntity<>(map, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(body, status);
        }
    }

}