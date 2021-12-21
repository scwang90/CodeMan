package ${packageName}.config;

import ${packageName}.model.conf.AppConfig;
import ${packageName}.util.EnumConverterFactory;
import lombok.AllArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.format.FormatterRegistry;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * WebMvc配置
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Configuration
@AllArgsConstructor
public class WebMvcConfig implements WebMvcConfigurer {

    private final AppConfig config;

    /**
     * 添加跨域列表
     */
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        AppConfig.CorsConfig cors = config.getCors();
        registry.addMapping(cors.getMappging())
                .allowedMethods(cors.getAllowedMethods())
                .allowCredentials(cors.isAllowCredentials())
                .exposedHeaders(cors.getExposedHeaders().split(";"))
                .allowedOriginPatterns(cors.getAllowedOriginPatterns().split(";"));
    }

    /**
     * 绑定枚举类型参数
     */
    @Override
    public void addFormatters(FormatterRegistry registry) {
        registry.addConverterFactory(new EnumConverterFactory());
    }

}
