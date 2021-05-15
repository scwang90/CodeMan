package ${packageName}.exception

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

    constructor(s: String) : super(s) {
        this.code = HttpStatus.FORBIDDEN.value()
    }

    constructor(code: Int, s: String) : super(s) {
        this.code = code
    }

    constructor(s: String, throwable: Throwable) : super(s, throwable) {
        this.code = HttpStatus.FORBIDDEN.value()
    }

    constructor(throwable: Throwable) : super(throwable) {
        this.code = HttpStatus.FORBIDDEN.value()
    }

}