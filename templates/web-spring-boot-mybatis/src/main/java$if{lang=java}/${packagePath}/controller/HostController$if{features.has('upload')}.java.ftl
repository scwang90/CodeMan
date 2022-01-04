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

import static ${packageName}.service.HostService.urlSchemeHostPort;

/**
 * Host 服务配置
 * 由代码生成器生成，可以修改
 * 但是如果删除，下次继续生成时，又会出现
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

}
