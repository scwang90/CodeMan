package ${packageName}.controller;

import ${packageName}.model.conf.ClientConfig;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import springfox.documentation.annotations.ApiIgnore;

import javax.servlet.http.HttpServletRequest;

/**
 * Host 服务配置
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@ApiIgnore
@Controller
public class HostController {

    private static ClientConfig CONFIG = null;

    public HostController(ClientConfig config) {
        CONFIG = config;
    }
    /**
     * 获取服务器链接前缀
     * @param request 请求对象
     * @return url 协议/主机/端口
     */
    public static String urlSchemeHostPort(HttpServletRequest request) {
        String url = CONFIG != null ? CONFIG.getVisitHost() : null;
        if (StringUtils.isEmpty(url)) {
            url = String.format("%s://%s:%d", request.getScheme(), request.getServerName(), request.getServerPort());
        } else if (!url.contains("://")) {
            url = String.format("%s://%s", request.getScheme(), url);
        }
        if (request.getServerPort() == 80 && url.startsWith("http:")) {
            url = url.replace(":80", "");
        } else if (request.getServerPort() == 443 && url.startsWith("https:")) {
            url = url.replace(":443", "");
        }
        if (!StringUtils.isEmpty(request.getContextPath())) {
            url = String.format("%s/%s", url, request.getContextPath());
        }
        return url;
    }

}
