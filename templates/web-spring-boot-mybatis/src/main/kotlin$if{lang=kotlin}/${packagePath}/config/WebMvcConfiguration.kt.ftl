package ${packageName}.config

import ${packageName}.filter.AutoApiInterceptor
import ${packageName}.model.conf.AppConfig
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.context.annotation.Configuration
import org.springframework.format.FormatterRegistry
import org.springframework.web.servlet.config.annotation.CorsRegistry
import org.springframework.web.servlet.config.annotation.InterceptorRegistry
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer

/**
 * WebMvc配置
 *
 * 由代码生成器生成，可以修改
 * 但是如果删除，下次继续生成时，又会出现
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Configuration
class WebMvcConfiguration : WebMvcConfigurer {

    @Autowired
    private lateinit var config:AppConfig

    /**
     * 添加跨域列表
     */
    override fun addCorsMappings(registry: CorsRegistry) {
        config.cors.apply {
            registry.addMapping(mappging)
                    .allowedMethods(allowedMethods)
                    .allowCredentials(allowCredentials)
                    .exposedHeaders(*exposedHeaders.split(";").toTypedArray())
                    .allowedOriginPatterns(*allowedOriginPatterns.split(";").toTypedArray())
        }
    }

    /**
     * 绑定枚举类型参数
     */
    override fun addFormatters(registry: FormatterRegistry) {
        registry.addConverterFactory(EnumConverterFactory())
    }

    /**
     * 添加拦截器
     */
    override fun addInterceptors(registry: InterceptorRegistry) {
        registry.addInterceptor(AutoApiInterceptor()).addPathPatterns("/api/auto/**")
    }

}

