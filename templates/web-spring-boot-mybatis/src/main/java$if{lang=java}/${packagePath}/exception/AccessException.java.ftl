package ${packageName}.exception;

import org.springframework.http.HttpStatus;

/**
 * 自定义异常 - 权限不足
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public class AccessException extends CodeException {
    
    public AccessException() {
        setCode(HttpStatus.FORBIDDEN.value());
    }

    public AccessException(String s) {
        super(s);
        setCode(HttpStatus.FORBIDDEN.value());
    }

    public AccessException(int code, String s) {
        super(s);
        setCode(code);
    }

    public AccessException(String s, Throwable throwable) {
        super(s, throwable);
        setCode(HttpStatus.FORBIDDEN.value());
    }

    public AccessException(Throwable throwable) {
        super(throwable);
        setCode(HttpStatus.FORBIDDEN.value());
    }
}
