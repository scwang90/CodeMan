package ${packageName}.exception

import ${packageName}.constant.ResultCode

/**
 * 自定义异常 - 错误码
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
abstract class CodeException : RuntimeException {

    var code = 0
        protected set

    constructor() {}
    constructor(message: String) : super(message) {}
    constructor(message: String, throwable: Throwable) : super(message, throwable) {}
    constructor(throwable: Throwable) : super(throwable) {}
    constructor(resultCode: ResultCode): super(resultCode.msg) {
        code = resultCode.code
    }

}