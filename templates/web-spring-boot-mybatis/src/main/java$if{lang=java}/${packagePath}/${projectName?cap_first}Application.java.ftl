package ${packageName};

import ${packageName}.model.conf.AppConfig;
import ${packageName}.util.EnumConverterFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Configuration;
import org.springframework.format.FormatterRegistry;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * SpringBoot 程序入口
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Configuration
@SpringBootApplication
public class ${projectName?cap_first}Application implements WebMvcConfigurer {

    private final AppConfig config;

    public TravelerServerApplication(AppConfig config) {
        this.config = config;
    }

    /**
     * 添加跨域列表
     */
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/api/**")
            .allowedMethods("*")
            .allowCredentials(true)
            .exposedHeaders("x-auth-token","Content-Type")
            .allowedOriginPatterns(config.getCors().getAllowedOriginPatterns().split(";"));
    }

    /**
     * 绑定枚举类型参数
     */
    @Override
    public void addFormatters(FormatterRegistry registry) {
        registry.addConverterFactory(new EnumConverterFactory());
    }

    public static void main(String[] args) {
        SpringApplication.run(${projectName?cap_first}Application.class, args);
    }

}
