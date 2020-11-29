package ${packageName}.exception;

/**
 * 客户端自定义异常
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@SuppressWarnings("unused")
public class ClientException extends RuntimeException {

    public ClientException() {
    }

    public ClientException(String s) {
        super(s);
    }

    public ClientException(String s, Throwable throwable) {
        super(s, throwable);
    }

    public ClientException(Throwable throwable) {
        super(throwable);
    }
}

