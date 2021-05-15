package ${packageName}.exception

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

    constructor(s: String) : super(s) {
        this.code = HttpStatus.INTERNAL_SERVER_ERROR.value()
    }

    constructor(code: Int, s: String) : super(s) {
        this.code = code
    }

    constructor(s: String, throwable: Throwable) : super(s, throwable) {
        this.code = HttpStatus.INTERNAL_SERVER_ERROR.value()
    }

    constructor(throwable: Throwable) : super(throwable) {
        this.code = HttpStatus.INTERNAL_SERVER_ERROR.value()
    }

}