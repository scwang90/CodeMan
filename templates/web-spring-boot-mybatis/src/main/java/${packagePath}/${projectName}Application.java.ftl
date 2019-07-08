package ${packageName};

import ${packageName}.util.EnumConverterFactory;
import ${packageName}.interceptor.LoginInterceptor;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.format.FormatterRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * SpringBoot 程序入口
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Configuration
@SpringBootApplication
public class ${projectName}Application implements WebMvcConfigurer {

    /**
     * 添加登录验证拦截器
     */
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new LoginInterceptor())
                .addPathPatterns("/api/**")
                .addPathPatterns("/admin/**")
                .excludePathPatterns("/api/v1/auth/*")
                .excludePathPatterns("/admin/login");
    }

    /**
     * 绑定枚举类型参数
     */
    @Override
    public void addFormatters(FormatterRegistry registry) {
        registry.addConverterFactory(new EnumConverterFactory());
    }

    public static void main(String[] args) {
        SpringApplication.run(${projectName}Application.class, args);
    }

}
