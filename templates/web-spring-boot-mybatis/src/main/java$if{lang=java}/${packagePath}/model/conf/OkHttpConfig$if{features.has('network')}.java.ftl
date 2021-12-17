package ${packageName}.model.conf;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * 配置模型 - 网络配置
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Data
@Component
@ConfigurationProperties(prefix = "app.okhttp")
public class OkHttpConfig {
    private int proxyPort = 0;
    private String proxyHost = "";
    private boolean proxyEnable = false;
}
