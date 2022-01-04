package ${packageName}.exception;

import ${packageName}.constant.ResultCode;
import org.springframework.http.HttpStatus;

/**
 * 自定义异常 - 错误的请求
 *
 * 由代码生成器生成，可以修改
 * 但是如果删除，下次继续生成时，又会出现
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

    public ClientException(ResultCode resultCode) {
        super(resultCode);
    }
}

