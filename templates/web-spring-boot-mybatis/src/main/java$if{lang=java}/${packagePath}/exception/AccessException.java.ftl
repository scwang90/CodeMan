package ${packageName}.exception;

/**
 * 自定义异常 - 客户端权限不足
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public class AccessException extends ClientException {

    public AccessException() {
    }

    public AccessException(String s) {
        super(s);
    }

    public AccessException(String s, Throwable throwable) {
        super(s, throwable);
    }

    public AccessException(Throwable throwable) {
        super(throwable);
    }
}
