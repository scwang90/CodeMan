package ${packageName}.exception

import ${packageName}.constant.ResultCode

import org.springframework.http.HttpStatus

/**
 * 自定义异常 - 服务器内部错误
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
class ServiceException : CodeException {

    constructor() {
        this.code = HttpStatus.INTERNAL_SERVER_ERROR.value()
    }

    constructor(message: String) : super(message) {
        this.code = HttpStatus.INTERNAL_SERVER_ERROR.value()
    }

    constructor(code: Int, message: String) : super(message) {
        this.code = code
    }

    constructor(message: String, throwable: Throwable) : super(message, throwable) {
        this.code = HttpStatus.INTERNAL_SERVER_ERROR.value()
    }

    constructor(throwable: Throwable) : super(throwable) {
        this.code = HttpStatus.INTERNAL_SERVER_ERROR.value()
    }

    constructor(status: ResultCode): super(status)
}