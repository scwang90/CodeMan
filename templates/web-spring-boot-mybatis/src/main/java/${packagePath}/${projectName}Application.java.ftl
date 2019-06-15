package ${packageName};

import ${packageName}.interceptor.LoginInterceptor;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
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
 * @date ${.now?string("yyyy-MM-dd HH:mm:ss zzzz")}
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
     * 创建Api文档
     * path:/doc
     * path:/swagger
     * path:/swagger-ui.html
     */
    @Bean
    public Docket createManagerApi() {
        return new Docket(DocumentationType.SWAGGER_2).groupName("后台管理")
                .apiInfo(new ApiInfoBuilder()
                        .title("${projectName} 后台文档")//页面标题
                        .contact(new Contact("${author}", "", "example@hotmail.com"))//创建人
                        .version("1.0")//版本号
                        .description("${projectName} 管理后台 API")//描述
                        .build())
                .select()
                .apis(RequestHandlerSelectors.basePackage("${packageName}.controller"))
                .paths(PathSelectors.any())
                .build();
    }

    public static void main(String[] args) {
        SpringApplication.run(${projectName}Application.class, args);
    }

}
