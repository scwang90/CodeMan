package ${packageName}.exception;

import ${packageName}.constant.ResultCode;
import org.springframework.http.HttpStatus;

/**
 * 自定义异常 - 服务器内部错误
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@SuppressWarnings("unused")
public class ServiceException extends CodeException {

    public ServiceException() {
        setCode(HttpStatus.INTERNAL_SERVER_ERROR.value());
    }

    public ServiceException(Throwable throwable) {
        super(throwable);
        setCode(HttpStatus.INTERNAL_SERVER_ERROR.value());
    }

    public ServiceException(ResultCode resultCode) {
        super(resultCode);
    }

    public ServiceException(ResultCode resultCode, Throwable throwable) {
        super(resultCode, throwable);
    }

}

