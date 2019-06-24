package ${packageName}.config;

import org.springframework.boot.web.servlet.MultipartConfigFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.servlet.MultipartConfigElement;

/**
 * 文件上传配置
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Configuration
public class UploadConfigurer {

    /**
     * 文件上传配置
     */
    @Bean
    public MultipartConfigElement multipartConfigElement() {
        MultipartConfigFactory factory = new MultipartConfigFactory();
        //单个文件最大
        factory.setMaxFileSize("80MB"); //KB,MB
        //设置总上传数据总大小
        factory.setMaxRequestSize("102400KB");
        return factory.createMultipartConfig();
    }

}
