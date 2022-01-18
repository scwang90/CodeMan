package ${packageName}.config

import com.fasterxml.jackson.databind.ObjectMapper
import ${packageName}.filter.JsonParamFilter
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.web.servlet.FilterRegistrationBean
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import javax.servlet.Filter

/**
 * 配置类 - 注入过滤器
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Configuration
class FilterConfiguration {

    @Bean
    fun jsonParamFilterBean(@Autowired jackson: ObjectMapper):FilterRegistrationBean<*> {
        val bean = FilterRegistrationBean<Filter>();
        bean.order = 1
        bean.setName("jsonParamFilter")
        bean.addUrlPatterns("/api/*")
        bean.filter = JsonParamFilter(jackson)
        return bean
    }

}
