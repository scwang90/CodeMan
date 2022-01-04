package ${packageName}.service;

import ${packageName}.model.conf.AppConfig;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;

import javax.servlet.http.HttpServletRequest;

/**
 * Host 服务配置
 *
 * 根据请求计算客户端访问到URL，如：http://127.0.0.1:8080
 * 如果配置文件中直接配置了 Host，则直接读取配置文件的配置
 * 主要用于文件下载功能，返回客户端文件下载地址
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Service
public class HostService {

    private static AppConfig CONFIG = null;

    public HostService(AppConfig config) {
        CONFIG = config;
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
