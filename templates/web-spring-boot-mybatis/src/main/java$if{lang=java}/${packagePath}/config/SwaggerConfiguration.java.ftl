package ${packageName}.config;

import ${packageName}.model.conf.AppConfig;

import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.MediaType;
import org.springframework.util.StringUtils;
import org.springframework.validation.annotation.Validated;

import springfox.documentation.RequestHandler;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2WebMvc;

import java.util.Arrays;
import java.util.Collections;
import java.util.LinkedHashSet;
import java.util.function.Predicate;

/**
 * Swagger文档配置
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Configuration
@EnableSwagger2WebMvc
@ConditionalOnProperty(name = "enabled", prefix = "app.swagger", havingValue = "true")
public class SwaggerConfiguration {

    final AppConfig config;

    public SwaggerConfiguration(AppConfig config) {
        if (!StringUtils.hasText(config.getSwaggerHost()) && StringUtils.hasText(config.getVisitHost())) {
            config.setSwaggerHost(config.getVisitHost().replaceAll("https?://", ""));
        }
        this.config = config;
    }

    /**
     * 创建管理Api文档
     * path:/doc
     * path:/swagger
     * path:/swagger-ui.html
     */
    @Bean
    public Docket createAutoApi() {
        Predicate<RequestHandler> manager = RequestHandlerSelectors.basePackage("${packageName}.controller.auto");
        Docket docket = new Docket(DocumentationType.SWAGGER_2).groupName("2.后台管理")
                .apiInfo(new ApiInfoBuilder()
                        .title("${projectName} 后台文档")//页面标题
                        .contact(new Contact("${author}", "", "scwang90@hotmail.com"))//创建人
                        .version("1.0")//版本号
                        .description("${projectName} 管理后台 API")//描述
                        .build())
                .produces(new LinkedHashSet<>(Collections.singletonList(MediaType.APPLICATION_JSON_VALUE)))
                .consumes(new LinkedHashSet<>(Arrays.asList(MediaType.APPLICATION_FORM_URLENCODED_VALUE, MediaType.APPLICATION_JSON_VALUE)))
                .select()
                .apis(manager)
                .paths(PathSelectors.any())
                .build();
        docket.host(config.getSwaggerHost());
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
                .produces(new LinkedHashSet<>(Collections.singletonList(MediaType.APPLICATION_JSON_VALUE)))
                .consumes(new LinkedHashSet<>(Arrays.asList(MediaType.APPLICATION_FORM_URLENCODED_VALUE, MediaType.APPLICATION_JSON_VALUE)))
                .select()
                .apis(pack.and(val))
                .paths(PathSelectors.any())
                .build();
        docket.host(config.getSwaggerHost());
        return docket;
    }

}
