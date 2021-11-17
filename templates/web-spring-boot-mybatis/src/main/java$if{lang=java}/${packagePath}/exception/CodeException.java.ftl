package ${packageName}.exception;

import ${packageName}.constant.ResultCode;

/**
 * 自定义异常 - 错误码
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public abstract class CodeException extends RuntimeException {

    private int code = 0;

    public CodeException() {
    }

    public CodeException(String s) {
        super(s);
    }

    public CodeException(String s, Throwable throwable) {
        super(s, throwable);
    }

    public CodeException(Throwable throwable) {
        super(throwable);
    }

    public CodeException(ResultCode resultCode) {
        super(resultCode.message);
        this.code = resultCode.code;
    }

    public int getCode() {
        return code;
    }

    protected void setCode(int code) {
        this.code = code;
    }
}
