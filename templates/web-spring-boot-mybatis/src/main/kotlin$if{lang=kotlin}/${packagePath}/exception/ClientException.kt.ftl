package ${packageName}.exception

import ${packageName}.constant.ResultCode

import org.springframework.http.HttpStatus

/**
 * 自定义异常 - 错误的请求
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
open class ClientException : CodeException {

    constructor() {
        this.code = HttpStatus.BAD_REQUEST.value()
    }

    constructor(message: String) : super(message) {
        this.code = HttpStatus.BAD_REQUEST.value()
    }

    constructor(code: Int, message: String) : super(message) {
        this.code = code
    }

    constructor(message: String, throwable: Throwable) : super(message, throwable) {
        this.code = HttpStatus.BAD_REQUEST.value()
    }

    constructor(throwable: Throwable) : super(throwable) {
        this.code = HttpStatus.BAD_REQUEST.value()
    }

    constructor(status: ResultCode): super(status)

}