package ${packageName}.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import ${packageName}.exception.ClientException;
import ${packageName}.exception.CodeException;
import ${packageName}.mapper.HashErrorMapper;
import ${packageName}.model.api.ApiResult;
import ${packageName}.model.conf.AppConfig;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.web.ServerProperties;
import org.springframework.boot.autoconfigure.web.servlet.error.BasicErrorController;
import org.springframework.boot.autoconfigure.web.servlet.error.ErrorViewResolver;
import org.springframework.boot.web.servlet.error.ErrorAttributes;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindException;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.MissingRequestHeaderException;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.ServletWebRequest;
import org.springframework.web.multipart.MultipartException;
import springfox.documentation.annotations.ApiIgnore;
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
 *
 * 由代码生成器生成，可以修改
 * 但是如果删除，下次继续生成时，又会出现
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Slf4j
@ApiIgnore
@RestControllerAdvice
public class ErrorController extends BasicErrorController {

    private final AppConfig config;
    private final ObjectMapper mapper;
    private final ErrorAttributes error;
    private final HashErrorMapper errorMapper;

    public ErrorController(@Autowired(required = false) HashErrorMapper errorMapper, ObjectMapper mapper, AppConfig config, ErrorAttributes error, ServerProperties server, ObjectProvider<ErrorViewResolver> errorView) {
        super(error, server.getError(), errorView.stream().collect(Collectors.toList()));
        this.error = error;
        this.config = config;
        this.mapper = mapper;
        this.errorMapper = errorMapper;
    }

    @ExceptionHandler(CodeException.class)
    public ApiResult<Object> handle(CodeException ex) {
        String message = ex.getMessage();
        if (ex instanceof ClientException) {
            log.debug(ex.getMessage());
        } else {
            if (!config.isOriginalError()) {
                message = "服务器内部错误";
            }
            log.error(ex.getMessage(), ex);
        }
        return ApiResult.fail(ex, message);
    }

    @ExceptionHandler(BindException.class)
    public ApiResult<Object> handler(BindException ex) {
        log.debug(ex.getMessage());
        String message = "参数验证错误";
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
        if (messages.size() == 1) {
            message = messages.get(0);
        }
        return new ApiResult<>(null, HttpStatus.BAD_REQUEST.value(), message, messages);
    }

    @ExceptionHandler(ValidationException.class)
    public ApiResult<Object>  handler(ValidationException ex) {
        log.debug(ex.getMessage());
        String message = ex.getMessage();
        if (ex instanceof ConstraintViolationException) {
            message = "参数验证错误";
            List<String> messages = new LinkedList<>();
            for (ConstraintViolation<?> constraint : ((ConstraintViolationException) ex).getConstraintViolations()) {
                messages.add(constraint.getPropertyPath() + ":" + constraint.getMessageTemplate());
            }
            if (messages.size() == 1) {
                message = messages.get(0);
            }
            return new ApiResult<>(null, HttpStatus.BAD_REQUEST.value(), message, messages);
        }
        return ApiResult.fail(HttpStatus.BAD_REQUEST.value(), message);
    }

    @ExceptionHandler(MissingRequestHeaderException.class)
    public ApiResult<Object> handler(MissingRequestHeaderException ex) {
        log.debug(ex.getMessage());
        String message = ex.getMessage();
        if (StringUtils.hasText(ex.getHeaderName())) {
            message = "缺少Header参数：" + ex.getHeaderName();
        }
        return new ApiResult<>(null, HttpStatus.BAD_REQUEST.value(), message, null);
    }

    @ExceptionHandler(MissingServletRequestParameterException.class)
    public ApiResult<Object> handler(MissingServletRequestParameterException ex) {
        log.debug(ex.getMessage());
        String message = ex.getMessage();
        if (StringUtils.hasText(ex.getParameterName())) {
            message = "缺少Query参数：" + ex.getParameterName();
        }
        return new ApiResult<>(null, HttpStatus.BAD_REQUEST.value(), message, null);
    }

    @ExceptionHandler(MultipartException.class)
    public ApiResult<Object> handler(Throwable ex) {
        log.debug(ex.getMessage());
        String message = ex.getMessage();
        while (ex.getCause() != null && ex.getCause() != ex) {
            ex = ex.getCause();
            message = ex.getMessage();
        }
        return new ApiResult<>(null, HttpStatus.BAD_REQUEST.value(), message, null);
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

        while (cause != null) {
            message.append(" <- ").append(cause.getMessage());
            if (cause.getCause() == cause) {
                break;
            } else {
                cause = cause.getCause();
            }
        }

        if (error instanceof CodeException) {
            status = HttpStatus.valueOf(((CodeException) error).getCode());
        } else if (cause instanceof CodeException) {
            status = HttpStatus.valueOf(((CodeException) cause).getCode());
        } else if (status.value() >= 500){
            String errorHash = null;
            if (errorMapper != null && error != null) {
                try {
                    errorHash = errorMapper.persistException(error, "服务器内部错误");
                } catch (Exception e) {
                    message.insert(0, "计算异常哈希失败：" + e.getMessage() + "\n");
                }
            }
            if (!config.isOriginalError() && error != null) {
                if (errorHash != null) {
                    message = new StringBuilder("错误代码:");
                    message.append(errorHash);
                } else {
                    message = new StringBuilder("服务器内部错误");
                }
            } else if (cause instanceof SQLTransientConnectionException) {
                message = new StringBuilder("连接数据库异常：" + cause.getMessage());
            }
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