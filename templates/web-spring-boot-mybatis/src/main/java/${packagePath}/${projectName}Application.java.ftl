package ${packageName};

import com.alibaba.druid.support.http.StatViewServlet;
import com.alibaba.druid.support.http.WebStatFilter;
import ${packageName}.constant.CommonApi;
import ${packageName}.interceptor.LoginInterceptor;
import com.google.common.base.Predicate;
import com.google.common.base.Predicates;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.MultipartConfigFactory;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.MultipartConfigElement;

import springfox.documentation.RequestHandler;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

/**
 * SpringBoot 程序入口
 * @author ${author}
 * @since ${.now?string("yyyy-MM-dd zzzz")}
 */
@Configuration
@EnableSwagger2
@SpringBootApplication
public class ${projectName}Application implements WebMvcConfigurer {

    /**
     * 添加登录验证拦截器
     */
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new LoginInterceptor())
                .addPathPatterns("/api/**")
                .addPathPatterns("/admin/**")
                .excludePathPatterns("/api/v1/auth/*")
                .excludePathPatterns("/admin/login");
    }

    /**
     * 创建管理Api文档
     * path:/doc
     * path:/swagger
     * path:/swagger-ui.html
     */
    @Bean
    public Docket createManagerApi() {
        Predicate<RequestHandler> handler = RequestHandlerSelectors.basePackage("${packageName}.controller.manager");
        Predicate<RequestHandler> common = RequestHandlerSelectors.withClassAnnotation(CommonApi.class);
        return new Docket(DocumentationType.SWAGGER_2).groupName("2.后台管理")
                .apiInfo(new ApiInfoBuilder()
                        .title("${projectName} 后台文档")//页面标题
                        .contact(new Contact("${author}", "", "example@hotmail.com"))//创建人
                        .version("1.0")//版本号
                        .description("${projectName} 管理后台 API")//描述
                        .build())
                .select()
                .apis(Predicates.or(common, handler))
                .paths(PathSelectors.any())
                .build();
    }

    /**
     * 创建Api文档
     * path:/doc
     * path:/swagger
     * path:/swagger-ui.html
     */
    @Bean
    public Docket createApi() {
        Predicate<RequestHandler> common = RequestHandlerSelectors.withClassAnnotation(CommonApi.class);
        return new Docket(DocumentationType.SWAGGER_2).groupName("1.接口文档")
                .apiInfo(new ApiInfoBuilder()
                    .title("${projectName} 接口文档")//页面标题
                    .contact(new Contact("${author}", "", "example@hotmail.com"))//创建人
                    .version("1.0")//版本号
                    .description("${projectName} 接口文档 API")//描述
                    .build())
                .select()
                .apis(common)
                .paths(PathSelectors.any())
                .build();
    }

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


    /**
     * 文件上传配置
     */
    @Bean
    public MultipartConfigElement multipartConfigElement() {
        MultipartConfigFactory factory = new MultipartConfigFactory();
        //单个文件最大
        factory.setMaxFileSize("80MB"); //KB,MB
        //设置总上传数据总大小
        factory.setMaxRequestSize("102400KB");
        return factory.createMultipartConfig();
    }

    public static void main(String[] args) {
        SpringApplication.run(${projectName}Application.class, args);
    }

}
