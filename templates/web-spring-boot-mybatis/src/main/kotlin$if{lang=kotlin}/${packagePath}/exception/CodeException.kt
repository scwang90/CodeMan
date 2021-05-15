package ${packageName}.exception

/**
 * 自定义异常 - 错误码
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
abstract class CodeException : RuntimeException {

    var code = 0
        protected set

    constructor() {}
    constructor(s: String) : super(s) {}
    constructor(s: String, throwable: Throwable) : super(s, throwable) {}
    constructor(throwable: Throwable) : super(throwable) {}

}