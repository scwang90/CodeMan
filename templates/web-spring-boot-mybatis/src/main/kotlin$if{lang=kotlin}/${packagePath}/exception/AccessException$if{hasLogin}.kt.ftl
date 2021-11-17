package ${packageName}.exception

import ${packageName}.constant.ResultCode

import org.springframework.http.HttpStatus

/**
 * 自定义异常 - 权限不足
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
class AccessException : ClientException {

    constructor() {
        this.code = HttpStatus.FORBIDDEN.value()
    }

    constructor(message: String) : super(message) {
        this.code = HttpStatus.FORBIDDEN.value()
    }

    constructor(code: Int, message: String) : super(message) {
        this.code = code
    }

    constructor(message: String, throwable: Throwable) : super(message, throwable) {
        this.code = HttpStatus.FORBIDDEN.value()
    }

    constructor(throwable: Throwable) : super(throwable) {
        this.code = HttpStatus.FORBIDDEN.value()
    }

    constructor(status: ResultCode): super(status)

}