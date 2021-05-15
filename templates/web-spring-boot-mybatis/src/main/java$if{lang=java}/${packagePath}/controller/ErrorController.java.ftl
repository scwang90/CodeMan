package ${packageName}.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import ${packageName}.exception.ClientException;
import ${packageName}.exception.CodeException;
import ${packageName}.model.api.ApiResult;
import ${packageName}.model.conf.AppConfig;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.boot.autoconfigure.web.ServerProperties;
import org.springframework.boot.autoconfigure.web.servlet.error.BasicErrorController;
import org.springframework.boot.autoconfigure.web.servlet.error.ErrorViewResolver;
import org.springframework.boot.web.servlet.error.ErrorAttributes;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindException;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.ServletWebRequest;

import java.sql.SQLTransientConnectionException;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import javax.validation.ValidationException;

/**
 * 统一错误返回格式
 * 支持-区分服务器异常、客户端异常
 * 支持-配置是否返回原始错误信息
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Slf4j
@RestControllerAdvice
public class ErrorController extends BasicErrorController {
    
    private final ObjectMapper mapper;
    private final ErrorAttributes error;
    private final AppConfig config;

    public ErrorController(ObjectMapper mapper, AppConfig config, ErrorAttributes error, ServerProperties server, ObjectProvider<ErrorViewResolver> errorView) {
        super(error, server.getError(), errorView.stream().collect(Collectors.toList()));
        this.error = error;
        this.config = config;
        this.mapper = mapper;
    }

    @ExceptionHandler(CodeException.class)
    public ApiResult<Object> handle(CodeException ex) {
        String message = ex.getMessage();
        if (ex instanceof ClientException) {
            log.debug(ex.getMessage());
        } else {
            log.error(ex.getMessage(), ex);
        }
        return ApiResult.fail(ex.getCode(), message);
    }

    @ExceptionHandler(BindException.class)
    public ApiResult<Object> handler(BindException ex) {
        log.debug(ex.getMessage());
        String message = ex.getMessage();
        List<String> messages = new LinkedList<>();
        if (ex.hasGlobalErrors()) {
            for (ObjectError error : ex.getGlobalErrors()) {
                messages.add(String.format("%s:%s", error.getObjectName(), error.getDefaultMessage()));
            }
        }
        if (ex.hasFieldErrors()) {
            for (FieldError error : ex.getFieldErrors()) {
                messages.add(String.format("%s:%s:%s", error.getObjectName(), error.getField(), error.getDefaultMessage()));
            }
        }
        return new ApiResult<>(null, HttpStatus.BAD_REQUEST.value(), message, messages);
    }

    @ExceptionHandler(ValidationException.class)
    public ApiResult<Object>  handler(ValidationException ex) {
        log.debug(ex.getMessage());
        String message = ex.getMessage();
        if (ex instanceof ConstraintViolationException) {
            List<String> messages = new LinkedList<>();
            for (ConstraintViolation<?> constraint : ((ConstraintViolationException) error).getConstraintViolations()) {
                messages.add(constraint.getPropertyPath() + ":" + constraint.getMessageTemplate());
            }
            return new ApiResult<>(null, HttpStatus.BAD_REQUEST.value(), message, messages);
        }
        return ApiResult.fail(HttpStatus.BAD_REQUEST.value(), message);
    }
    
    @Override
    public ResponseEntity<Map<String, Object>> error(HttpServletRequest request) {
        HttpStatus status = getStatus(request);
        Map<String, Object> body = getErrorAttributes(request, getErrorAttributeOptions(request, MediaType.ALL));
        if (body.get("path") != null && !body.get("path").toString().startsWith("/api")) {
            return super.error(request);
        }

        StringBuilder message = new StringBuilder("" + body.get("error"));
        if (body.get("message") != null && body.get("message").toString().length() > 0) {
            message.append(" - ").append(body.get("message"));
        }

        Object errors = body.get("errors");
        Throwable error = this.error.getError(new ServletWebRequest(request));
        Throwable cause = error;
        while (cause != null && cause.getCause() != null && cause.getCause() != cause) {
            message.append(" <- ").append(cause.getMessage());
            cause = cause.getCause();
        }
        if (error instanceof CodeException) {
            status = HttpStatus.valueOf(((CodeException) error).getCode());
        } else if (!config.isOriginalError() && error != null) {
            message = new StringBuilder("服务器内部错误");
        } else if (cause instanceof SQLTransientConnectionException) {
            message = new StringBuilder("连接数据库异常：" + cause.getMessage());
        } else if (cause != null) {
            message.append(" <- ").append(cause.getMessage());
        }
        try {
            ApiResult<?> result = new ApiResult<>(null, status.value(), message.toString(), errors);
            //noinspection unchecked
            Map<String, Object> map = mapper.readValue(mapper.writeValueAsString(result), Map.class);
            return new ResponseEntity<>(map, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(body, status);
        }
    }

}