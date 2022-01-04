package ${packageName}.exception;

import ${packageName}.constant.ResultCode;

/**
 * 自定义异常 - 错误码
 *
 * 由代码生成器生成，可以修改
 * 但是如果删除，下次继续生成时，又会出现
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

    public CodeException(ResultCode resultCode, Throwable throwable) {
        super(resultCode.message, throwable);
        this.code = resultCode.code;
    }

    public int getCode() {
        return code;
    }

    protected void setCode(int code) {
        this.code = code;
    }
}
