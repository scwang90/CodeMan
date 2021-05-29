package ${packageName}.controller

import ${packageName}.model.conf.AppConfig
import org.springframework.stereotype.Controller
import org.springframework.util.ObjectUtils
import springfox.documentation.annotations.ApiIgnore

import javax.servlet.http.HttpServletRequest

/**
 * Host 服务配置
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@ApiIgnore
@Controller
class HostController {

    companion object {

        private var CONFIG: AppConfig? = null

        /**
         * 获取服务器链接前缀
         * @param request 请求对象
         * @return url 协议/主机/端口
         */
        fun urlSchemeHostPort(request: HttpServletRequest): String? {
            var url = if (CONFIG != null) CONFIG.visitHost else null
            if (url.isNullOrBlank()) {
                url = String.format("%s://%s:%d", request.scheme, request.serverName, request.serverPort)
            } else if (!url.contains("://")) {
                url = String.format("%s://%s", request.scheme, url)
            }
            if (request.serverPort == 80 && url.startsWith("http:")) {
                url = url.replace(":80", "")
            } else if (request.serverPort == 443 && url.startsWith("https:")) {
                url = url.replace(":443", "")
            }
            if (!ObjectUtils.isEmpty(request.contextPath)) {
                url = String.format("%s/%s", url, request.contextPath)
            }
            return url
        }
    }

    init {
        CONFIG = config
    }

}
