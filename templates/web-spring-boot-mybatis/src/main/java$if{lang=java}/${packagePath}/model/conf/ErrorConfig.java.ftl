package ${packageName}.model.conf;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * 错误信息配置
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Component
@ConfigurationProperties(prefix="app.error")
public class ErrorConfig {

    private boolean original;

    public boolean getOriginal() {
        return original;
    }

    public void setOriginal(boolean original) {
        this.original = original;
    }
}
