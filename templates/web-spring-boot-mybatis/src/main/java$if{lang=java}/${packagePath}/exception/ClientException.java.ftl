package ${packageName}.exception;

import org.springframework.http.HttpStatus;

/**
 * 客户端自定义异常
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@SuppressWarnings("unused")
public class ClientException extends CodeException {

    public ClientException() {
        setCode(HttpStatus.BAD_REQUEST.value());
    }

    public ClientException(String s) {
        super(s);
        setCode(HttpStatus.BAD_REQUEST.value());
    }

    public ClientException(int code, String s) {
        super(s);
        setCode(code);
    }

    public ClientException(String s, Throwable throwable) {
        super(s, throwable);
        setCode(HttpStatus.BAD_REQUEST.value());
    }

    public ClientException(Throwable throwable) {
        super(throwable);
        setCode(HttpStatus.BAD_REQUEST.value());
    }
}

