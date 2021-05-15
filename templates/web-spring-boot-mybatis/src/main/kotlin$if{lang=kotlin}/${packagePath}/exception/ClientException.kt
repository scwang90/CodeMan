package ${packageName}.exception

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

    constructor(s: String) : super(s) {
        this.code = HttpStatus.BAD_REQUEST.value()
    }

    constructor(code: Int, s: String) : super(s) {
        this.code = code
    }

    constructor(s: String, throwable: Throwable) : super(s, throwable) {
        this.code = HttpStatus.BAD_REQUEST.value()
    }

    constructor(throwable: Throwable) : super(throwable) {
        this.code = HttpStatus.BAD_REQUEST.value()
    }

}