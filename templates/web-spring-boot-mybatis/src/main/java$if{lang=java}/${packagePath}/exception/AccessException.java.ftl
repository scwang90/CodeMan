package ${packageName}.exception;

import ${packageName}.constant.ResultCode;
import org.springframework.http.HttpStatus;

/**
 * 自定义异常 - 权限不足
 *
 * 由代码生成器生成，可以修改
 * 但是如果删除，下次继续生成时，又会出现
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public class AccessException extends CodeException {
    
    public AccessException() {
        setCode(ResultCode.Forbidden.code);
    }

    public AccessException(String s) {
        super(s);
        setCode(ResultCode.Forbidden.code);
    }

    public AccessException(int code, String s) {
        super(s);
        setCode(code);
    }

    public AccessException(String s, Throwable throwable) {
        super(s, throwable);
        setCode(ResultCode.Forbidden.code);
    }

    public AccessException(Throwable throwable) {
        super(throwable);
        setCode(ResultCode.Forbidden.code);
    }

    public AccessException(ResultCode resultCode) {
        super(resultCode);
    }
}
