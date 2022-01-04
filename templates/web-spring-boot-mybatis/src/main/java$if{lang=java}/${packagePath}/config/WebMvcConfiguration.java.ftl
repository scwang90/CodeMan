package ${packageName}.config;

import ${packageName}.filter.AutoApiInterceptor;
import ${packageName}.model.conf.AppConfig;
import ${packageName}.util.EnumConverterFactory;
import lombok.AllArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.format.FormatterRegistry;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * WebMvc配置
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Configuration
@AllArgsConstructor
public class WebMvcConfiguration implements WebMvcConfigurer {

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

    /**
     * 拦截器配置
     * @param registry 拦截器注册器
     */
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        if (config.getAuto().isApiDisable()) {
            /*
             * 代码生成器为每张表生成了一些列的增删查改接口，存放在 auto 包中
             * 这些接口主要用于生成器生成项目初期演示，和开发时复制可用代码用的
             * 这些接口拥有最高的数据库权限，可以轻易删除任何数据，所以项目上线，这些接口需要被拦截
             * 本拦截器就主要用于拦截 auto 包中的所有接口
             */
            registry.addInterceptor(new AutoApiInterceptor()).addPathPatterns("/api/auto/**");
        }
    }
}
