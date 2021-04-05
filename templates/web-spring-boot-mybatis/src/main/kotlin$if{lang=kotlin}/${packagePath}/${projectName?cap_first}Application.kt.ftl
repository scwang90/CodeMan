package ${packageName}

import ${packageName}.interceptor.LoginInterceptor
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.web.servlet.config.annotation.InterceptorRegistry
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer
import springfox.documentation.builders.ApiInfoBuilder
import springfox.documentation.builders.PathSelectors
import springfox.documentation.builders.RequestHandlerSelectors
import springfox.documentation.service.Contact
import springfox.documentation.spi.DocumentationType
import springfox.documentation.spring.web.plugins.Docket
import springfox.documentation.swagger2.annotations.EnableSwagger2

/**
 * SpringBoot 程序入口
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Configuration
@EnableSwagger2
@SpringBootApplication
class ${projectName?cap_first}Application : WebMvcConfigurer {

    /**
     * 添加登录验证拦截器
     */
    override fun addInterceptors(registry: InterceptorRegistry) {
        registry.addInterceptor(LoginInterceptor())
                .addPathPatterns("/api/**")
                .addPathPatterns("/admin/**")
                .excludePathPatterns("/api/v1/auth/*")
                .excludePathPatterns("/admin/login")
        super.addInterceptors(registry)
    }

    /**
     * 创建Api文档
     * path:/doc
     * path:/swagger-ui.html
     */
    @Bean
    fun createManagerApi(): Docket {
        return Docket(DocumentationType.SWAGGER_2).groupName("后台管理")
                .apiInfo(ApiInfoBuilder()
                        .title("${projectName} 后台文档")//页面标题
                        .contact(Contact("${author}", "", "example@hotmail.com"))//创建人
                        .version("1.0")//版本号
                        .description("${projectName} 管理后台 API")//描述
                        .build())
                .select()
                .apis(RequestHandlerSelectors.basePackage("${packageName}.controller"))
                .paths(PathSelectors.any())
                .build()
    }

}

fun main(args: Array<String>) {
    runApplication<${projectName?cap_first}Application>(*args)
}
