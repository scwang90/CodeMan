package ${packageName}

import ${packageName}.config.EnumConverterFactory
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.format.FormatterRegistry
import org.springframework.web.servlet.config.annotation.CorsRegistry
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer
import java.util.*

/**
 * SpringBoot 程序入口
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Configuration
@SpringBootApplication
class ${projectName?cap_first}Application : WebMvcConfigurer {

    /**
     * 所有产生随机数到地方都使用同一个随机数生成器，优化生成器的随机性
     */
    @Bean
    fun random(): Random {
        return Random()
    }

    /**
     * 绑定枚举类型参数
     */
    override fun addFormatters(registry: FormatterRegistry) {
        registry.addConverterFactory(EnumConverterFactory())
    }

    /**
     * 添加跨域列表
     */
    override fun addCorsMappings(registry: CorsRegistry) {
        registry.addMapping("/api/**")
            .allowedMethods("*")
            .allowCredentials(true)
            .allowedOriginPatterns("*www.example.com*", "*localhost*", "*127.0.0.1*", "*0.0.0.0*")
    }

}

fun main(args: Array<String>) {
    runApplication<${projectName?cap_first}Application>(*args)
}
