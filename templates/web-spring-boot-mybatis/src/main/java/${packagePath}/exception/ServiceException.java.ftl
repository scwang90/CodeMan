package ${packageName}.exception;

/**
 * 服务器自定义异常
 * @author ${author}
 * @since ${.now?string("yyyy-MM-dd zzzz")}
 */
@SuppressWarnings("unused")
public class ServiceException extends RuntimeException {

    public ServiceException() {
    }

    public ServiceException(String s) {
        super(s);
    }

    public ServiceException(String s, Throwable throwable) {
        super(s, throwable);
    }

    public ServiceException(Throwable throwable) {
        super(throwable);
    }
}

