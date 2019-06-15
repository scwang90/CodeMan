package ${packageName}.exception

/**
 * 服务器自定义异常
 * @author ${author}
 * @since ${.now?string("yyyy-MM-dd HH:mm:ss zzzz")}
 */
open class ServiceException : RuntimeException {
    constructor() : super()
    constructor(message: String?) : super(message)
    constructor(message: String?, cause: Throwable?) : super(message, cause)
}