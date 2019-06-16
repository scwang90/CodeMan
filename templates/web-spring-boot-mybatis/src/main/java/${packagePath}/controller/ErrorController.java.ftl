package ${packageName}.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import ${packageName}.model.api.ApiResult;
import com.google.common.reflect.TypeToken;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.web.ErrorProperties;
import org.springframework.boot.autoconfigure.web.servlet.error.BasicErrorController;
import org.springframework.boot.web.servlet.error.DefaultErrorAttributes;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.FieldError;

import java.util.Collection;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import springfox.documentation.annotations.ApiIgnore;

/**
 * 统一错误返回格式
 * @author ${author}
 * @since ${.now?string("yyyy-MM-dd zzzz")}
 */
@ApiIgnore
@Controller
public class ErrorController extends BasicErrorController {

    @Autowired
    private ObjectMapper mapper;

    public ErrorController() {
        super(new DefaultErrorAttributes(), new ErrorProperties());
    }

    @Override
    public ResponseEntity<Map<String, Object>> error(HttpServletRequest request) {
        HttpStatus status = getStatus(request);
        HttpStatus statusResult = status;
        Map<String, Object> body = getErrorAttributes(request, isIncludeStackTrace(request, MediaType.ALL));
        String message = body.get("error") + "-" + body.get("message");
        Object errors = body.get("errors");
        if (errors instanceof Collection && ((Collection) errors).size() > 0) {
            Iterator iterator = ((Collection) errors).iterator();
            Object error = iterator.next();
            if (error instanceof FieldError) {
                List<String> messages = new LinkedList<>();
                do {
                    if (error == null) {
                        error = iterator.next();
                    }
                    Object field = ((FieldError) error).getField();
                    Object defaultMessage = ((FieldError) error).getDefaultMessage();
                    message = field + ":" + defaultMessage;
                    messages.add(message);
                    error = null;
                } while (iterator.hasNext());
                errors = messages;
                statusResult = HttpStatus.OK;
            }
        }
        ApiResult result = new ApiResult<>(null, status.value(), message, errors);
        try {
            String json = mapper.writeValueAsString(result);
            Class<? super Map<String, Object>> type = new TypeToken<Map<String, Object>>() {}.getRawType();
            Map<String, Object> map = mapper.readValue(json, (Class<Map<String, Object>>)type);
            return new ResponseEntity<>(map, statusResult);
        } catch (Exception e) {
            return new ResponseEntity<>(body, status);
        }
    }

}
