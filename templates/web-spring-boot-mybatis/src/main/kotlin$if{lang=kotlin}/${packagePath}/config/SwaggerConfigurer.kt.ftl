package ${packageName}.config

import ${packageName}.constant.ResultCode
import ${packageName}.model.conf.AppConfig
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.http.MediaType
import org.springframework.web.bind.annotation.RequestMethod
import springfox.documentation.builders.ApiInfoBuilder
import springfox.documentation.builders.PathSelectors
import springfox.documentation.builders.RequestHandlerSelectors
import springfox.documentation.schema.ModelRef
import springfox.documentation.service.*
import springfox.documentation.spi.DocumentationType
import springfox.documentation.spi.service.contexts.SecurityContext
import springfox.documentation.spring.web.plugins.Docket
import springfox.documentation.swagger2.annotations.EnableSwagger2WebMvc
import java.util.function.Predicate

/**
 * Swagger文档配置
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Configuration
@EnableSwagger2WebMvc
@ConditionalOnProperty(name = ["enabled"], prefix = "app.swagger", havingValue = "true")
class SwaggerConfigurer(private val config: AppConfig) {

    init {
        config.run {
            if (swagger.host.isBlank() && client.visitHost.isNotBlank()) {
                swagger.host = client.visitHost.replace("https?://".toRegex(), "")
            }
        }
    }

    /**
     * 创建Api文档 - 开发版本
     * path:/doc
     * path:/swagger
     * path:/swagger-ui.html
     */
    @Bean
    fun createApi(): Docket {
        val all = RequestHandlerSelectors.basePackage("com.fecred.midaier.controller")
        val auto = RequestHandlerSelectors.basePackage("com.fecred.midaier.controller.auto")
        val docket = Docket(DocumentationType.SWAGGER_2).groupName("1.api")
            .apiInfo(ApiInfoBuilder()
                .version("1.0") //版本号
                .description("${projectName} 接口文档 API") //描述
                .title("${projectName} 接口文档 - 开发版本") //页面标题
                .contact(Contact("${author}", "", "scwang90@hotmail.com")) //创建人
                .build())
            // 如果项目设计多端登录，并且接口多端设计，可以取消下面注释，开启 Client
//            .globalOperationParameters(listOf(ParameterBuilder()
//                .name("client")
//                .description("平台信息")
//                .allowableValues(AllowableListValues(Client.values().map { it.code }.toList(), "string"))
//                .parameterType("header")
//                .defaultValue(Client.App.code)
//                .hidden(true)
//                .required(true)
//                .modelRef(ModelRef("string"))
//                .build()))
            .securitySchemes(listOf(ApiKey("认证信息", "Authorization", "header")))
            .securityContexts(listOf(SecurityContext.builder()
                .securityReferences(listOf(SecurityReference("认证信息", arrayOf(AuthorizationScope("global", "accessEverything")))))
                .forPaths(PathSelectors.regex("^(?!/api/(v1|web|app|applet|common)/(auth|sms)/).*$"))
                .build()))
            .produces(setOf(MediaType.APPLICATION_JSON_VALUE))
            .consumes(setOf(MediaType.APPLICATION_FORM_URLENCODED_VALUE, MediaType.APPLICATION_JSON_VALUE))
            .globalResponseMessage(RequestMethod.POST, ResultCode.values().map { ResponseMessage(it.code, it.msg, ModelRef("void"), emptyList(), emptyMap(), emptyList()) })
            .globalResponseMessage(RequestMethod.PUT, ResultCode.values().map { ResponseMessage(it.code, it.msg, ModelRef("void"), emptyList(), emptyMap(), emptyList()) })
            .globalResponseMessage(RequestMethod.GET, ResultCode.values().map { ResponseMessage(it.code, it.msg, ModelRef("void"), emptyList(), emptyMap(), emptyList()) })
            .globalResponseMessage(RequestMethod.DELETE, ResultCode.values().map { ResponseMessage(it.code, it.msg, ModelRef("void"), emptyList(), emptyMap(), emptyList()) })
            .select()
            .apis(all.and(Predicate.not(auto)))
            .paths(PathSelectors.any())
            .build()

        docket.host(config.swagger.host)
        return docket
    }

    /**
     * 创建Api文档 - 自动生成接口
     * path:/doc
     * path:/swagger
     * path:/swagger-ui.html
     */
    @Bean
    fun createAutoApi(): Docket {
        val pack = RequestHandlerSelectors.basePackage("${packageName}.controller.auto")
        val docket = Docket(DocumentationType.SWAGGER_2).groupName("2.auto")
            .apiInfo(ApiInfoBuilder()
                .version("1.0") //版本号
                .title("${projectName} 接口文档 - 自动API") //页面标题
                .description("${projectName} 接口文档 API") //描述
                .contact(Contact("${author}", "", "scwang90@hotmail.com")) //创建人
                .build())
            .securitySchemes(listOf(ApiKey("认证信息", "Authorization", "header")))
            .securityContexts(listOf(SecurityContext.builder()
                .securityReferences(listOf(SecurityReference("认证信息", arrayOf(AuthorizationScope("global", "accessEverything")))))
                .forPaths(PathSelectors.regex("^(?!/api/(v1|web|app|applet|common)/(auth|sms)/).*$"))
                .build()))
            .produces(setOf(MediaType.APPLICATION_JSON_VALUE))
            .consumes(setOf(MediaType.APPLICATION_FORM_URLENCODED_VALUE, MediaType.APPLICATION_JSON_VALUE))
            .globalResponseMessage(RequestMethod.POST, ResultCode.values().map { ResponseMessage(it.code, it.msg, ModelRef("void"), emptyList(), emptyMap(), emptyList()) })
            .globalResponseMessage(RequestMethod.PUT, ResultCode.values().map { ResponseMessage(it.code, it.msg, ModelRef("void"), emptyList(), emptyMap(), emptyList()) })
            .globalResponseMessage(RequestMethod.GET, ResultCode.values().map { ResponseMessage(it.code, it.msg, ModelRef("void"), emptyList(), emptyMap(), emptyList()) })
            .globalResponseMessage(RequestMethod.DELETE, ResultCode.values().map { ResponseMessage(it.code, it.msg, ModelRef("void"), emptyList(), emptyMap(), emptyList()) })
            .select()
            .apis(pack)
            .paths(PathSelectors.any())
            .build()
        docket.host(config.swagger.host)
        return docket
    }


}