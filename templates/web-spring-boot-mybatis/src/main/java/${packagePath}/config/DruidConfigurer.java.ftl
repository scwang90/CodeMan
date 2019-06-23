package ${packageName}.config;

import com.alibaba.druid.support.http.StatViewServlet;
import com.alibaba.druid.support.http.WebStatFilter;

import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

/**
 * 数据库连接池配置
 * @author ${author}
 * @since ${.now?string("yyyy-MM-dd zzzz")}
 */
@Configuration
public class DruidConfigurer {

    /**
     * 数据库连接池-数据监控
     */
    @Bean
    public ServletRegistrationBean druidStatViewServlet() {
        ServletRegistrationBean bean = new ServletRegistrationBean<>(new StatViewServlet(),"/druid/*");
        Map<String, String> params = new HashMap<>();
        //　可配的属性都在 StatViewServlet 和其父类下
        params.put("loginUsername", "admin");
        params.put("loginPassword", "admin");
        bean.setInitParameters(params);
        return bean;
    }

    /**
     * 数据库连接池-数据监控
     */
    @Bean
    public FilterRegistrationBean druidWebStatFilter() {
        FilterRegistrationBean bean = new FilterRegistrationBean<>(new WebStatFilter());
        Map<String, String> params = new HashMap<>();
        params.put("exclusions", "*.js,*.css,/druid/*");
        bean.setInitParameters(params);
        bean.setUrlPatterns(Collections.singletonList("/*"));
        return bean;
    }

}
