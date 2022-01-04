package ${packageName}.config;

import ${packageName}.filter.JsonParamFilter;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.catalina.connector.CoyoteInputStream;
import org.apache.catalina.connector.InputBuffer;
import org.apache.coyote.Request;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.MediaType;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.ByteBuffer;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.stream.Collectors;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import org.springframework.lang.NonNull;

/**
 * 配置类 - 注入过滤器
 *
 * 由代码生成器生成，可以修改
 * 但是如果删除，下次继续生成时，又会出现
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Configuration
public class FilterConfiguration {

    /**
     * JSON 参数过滤器，可以支持吧客户端发送的Json数据以Query或者Form方式接受
     */
    @Bean
    public FilterRegistrationBean<Filter> jsonParamFilterBean(@Autowired ObjectMapper jackson) {
        FilterRegistrationBean<Filter> bean = new FilterRegistrationBean<>();
        bean.setOrder(1);
        bean.setName("jsonParamFilter");
        bean.addUrlPatterns("/api/*");
        bean.setFilter(new JsonParamFilter(jackson));
        return bean;
    }

}
