package ${packageName}.config;

import com.fecred.medical.platform.annotation.CommonApi;
import com.google.common.base.Predicate;
import com.google.common.base.Predicates;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import springfox.documentation.RequestHandler;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

/**
 * Swagger文档配置
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Configuration
@EnableSwagger2
public class SwaggerConfigurer {

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

}
