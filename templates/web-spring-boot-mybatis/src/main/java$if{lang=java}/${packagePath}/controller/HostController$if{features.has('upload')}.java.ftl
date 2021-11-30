package ${packageName}.controller;

import ${packageName}.model.api.ApiResult;
import ${packageName}.model.conf.AppConfig;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import springfox.documentation.annotations.ApiIgnore;

import javax.servlet.http.HttpServletRequest;
import java.util.Enumeration;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Host 服务配置
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@ApiIgnore
@Controller
@RequestMapping("host")
public class HostController {

    private static AppConfig CONFIG = null;

    public HostController(AppConfig config) {
        CONFIG = config;
    }

    @ResponseBody
    @RequestMapping("visit")
    public ApiResult<Object> visitUrl(HttpServletRequest request) {
        Map<String, String> headers = new LinkedHashMap<>();
        Enumeration<String> headerNames = request.getHeaderNames();
        while (headerNames.hasMoreElements()){
            String headerName = headerNames.nextElement();
            headers.put(headerName, request.getHeader(headerName));
        }
        return ApiResult.success(Map.of(
                "urlCompute", urlSchemeHostPort(request),
                "urlFinally", urlSchemeHostPort(request, CONFIG),
                "headers", headers
        ));
    }

    /**
     * 获取服务器链接前缀
     * @param request 请求对象
     * @return url 协议/主机/端口
     */
    public static String urlSchemeHostPort(HttpServletRequest request) {
        return urlSchemeHostPort(request, CONFIG);
    }

    /**
     * 获取服务器链接前缀
     * @param request 请求对象
     * @param config 配置对象
     * @return url 协议/主机/端口
     */
    public static String urlSchemeHostPort(HttpServletRequest request, AppConfig config) {
        String url = config != null ? config.getVisitHost() : null;
        if (ObjectUtils.isEmpty(url)) {
            url = String.format("%s://%s:%d", request.getScheme(), request.getServerName(), request.getServerPort());
            if (request.getServerPort() == 80) {
                url = url.replace(":80", "");
            } else if (request.getServerPort() == 443) {
                url = url.replace(":443", "");
            }
        } else if (!url.contains("://")) {
            url = String.format("%s://%s", request.getScheme(), url);
        }
        if (!ObjectUtils.isEmpty(request.getContextPath())) {
            url = String.format("%s/%s", url, request.getContextPath());
        }
        return url;
    }

}
