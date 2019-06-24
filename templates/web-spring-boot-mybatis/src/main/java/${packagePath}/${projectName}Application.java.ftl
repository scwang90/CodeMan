package ${packageName};

import ${packageName}.util.EnumConverterFactory;
import ${packageName}.interceptor.LoginInterceptor;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.format.FormatterRegistry;
import org.springframework.validation.beanvalidation.MethodValidationPostProcessor;
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

    /**
     * 基础类型验证
     * hibernate-validator不支持基础类型的验证，springboot对其进行了扩展，添加了MethodValidationPostProcessor拦截器，可以实现对方法参数的校验。
     * 对基础类型的验证，必须要在Controller类上加 @Validated，同时配置 MethodValidationPostProcessor 才生效
     */
    @Bean
    public MethodValidationPostProcessor methodValidationPostProcessor() {
        return new MethodValidationPostProcessor();
    }

    public static void main(String[] args) {
        SpringApplication.run(${projectName}Application.class, args);
    }

}
