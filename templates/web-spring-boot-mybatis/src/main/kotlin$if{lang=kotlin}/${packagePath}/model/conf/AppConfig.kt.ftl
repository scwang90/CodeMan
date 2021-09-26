package ${packageName}.model.conf

import org.springframework.boot.context.properties.ConfigurationProperties
import org.springframework.stereotype.Component

/**
 * 配置类 - 项目配置汇总
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Component
@ConfigurationProperties(prefix = "app")
class AppConfig {

    var error: Error = Error()
    var client: Client = Client()
    var swagger: Swagger = Swagger()
    var cors: CorsConfig = CorsConfig()

    class Swagger {
        /* 代理主机地址 */
        var host = ""
        /** 是否启用代理 */
        var enabled = false
    }

    class Client {
        var visitHost: String = ""
    }

    class Error (
        /** 是否返回错误原始错误信息 */
        var original: Boolean = false
    )

    class CorsConfig {
        var mappging:String = "/api/**"
        var allowedMethods:String = "*"
        var allowCredentials:Boolean = true
        var allowedOriginPatterns:String = "*localhost*;*127.0.0.1*;*0.0.0.0*"
    }
}