package ${packageName}.config;

import ${packageName}.model.conf.ClientConfig;
import ${packageName}.model.conf.SwaggerConfig;

import com.google.common.base.Predicate;
import com.google.common.base.Predicates;

import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.util.StringUtils;
import org.springframework.validation.annotation.Validated;

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
@ConditionalOnProperty(name = "enabled", prefix = "app.swagger", havingValue = "true")
public class SwaggerConfigurer {

    final SwaggerConfig config;
    final ClientConfig clientConfig;

    public SwaggerConfigurer(SwaggerConfig config, ClientConfig clientConfig) {
        if (StringUtils.isEmpty(config.getHost()) && !StringUtils.isEmpty(clientConfig.getVisitHost())) {
            config.setHost(clientConfig.getVisitHost().replaceAll("https?://", ""));
        }
        this.config = config;
        this.clientConfig = clientConfig;
    }

    /**
     * 创建管理Api文档
     * path:/doc
     * path:/swagger
     * path:/swagger-ui.html
     */
    @Bean
    public Docket createManagerApi() {
        Predicate<RequestHandler> manager = RequestHandlerSelectors.basePackage("${packageName}.controller.manager");
        Docket docket = new Docket(DocumentationType.SWAGGER_2).groupName("2.后台管理")
                .apiInfo(new ApiInfoBuilder()
                        .title("${projectName} 后台文档")//页面标题
                        .contact(new Contact("${author}", "", "scwang90@hotmail.com"))//创建人
                        .version("1.0")//版本号
                        .description("${projectName} 管理后台 API")//描述
                        .build())
                .select()
                .apis(manager)
                .paths(PathSelectors.any())
                .build();
        docket.host(config.getHost());
        return docket;
    }

    /**
     * 创建Api文档
     * path:/doc
     * path:/swagger
     * path:/swagger-ui.html
     */
    @Bean
    public Docket createApi() {
        Predicate<RequestHandler> val = RequestHandlerSelectors.withClassAnnotation(Validated.class);
        Predicate<RequestHandler> pack = RequestHandlerSelectors.basePackage("${packageName}.controller");
        Docket docket = new Docket(DocumentationType.SWAGGER_2).groupName("1.接口文档")
                .apiInfo(new ApiInfoBuilder()
                    .title("${projectName} 接口文档")//页面标题
                    .contact(new Contact("${author}", "", "scwang90@hotmail.com"))//创建人
                    .version("1.0")//版本号
                    .description("${projectName} 接口文档 API")//描述
                    .build())
                .select()
                .apis(Predicates.and(pack, val))
                .paths(PathSelectors.any())
                .build();
        docket.host(config.getHost());
        return docket;
    }

}
