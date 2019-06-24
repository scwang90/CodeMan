package ${packageName}.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * 全局配置对象
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Component
@ConfigurationProperties("app.config")
public class AppConfigurer {

    private boolean debug = false;

    public boolean isDebug() {
        return debug;
    }

    public void setDebug(boolean debug) {
        this.debug = debug;
    }
}
