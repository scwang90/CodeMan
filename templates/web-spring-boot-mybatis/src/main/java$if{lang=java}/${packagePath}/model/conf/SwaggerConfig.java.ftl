package ${packageName}.model.conf;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * Swagger文档配置
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Component
@ConfigurationProperties(prefix="swagger")
public class SwaggerConfig {

    /**
     * 代理主机地址
     */
    private String host = "";
    /**
     * 是否启用代理
     */
    private boolean enabled = false;

    public String getHost() {
        return host;
    }

    public void setHost(String host) {
        this.host = host;
    }

    public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }
}
