package ${packageName}.model.conf;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * 认证Token配置
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Component
@ConfigurationProperties(prefix="auth.token")
public class AuthTokenConfig {

    /**
     * 凭证有效时间 (秒钟)
     */
    private int expiry = 60;
    /**
     * 凭证刷新间隔 (秒钟)
     */
    private int refresh = 10;

    public int getExpiry() {
        return expiry;
    }

    public void setExpiry(int expiry) {
        this.expiry = expiry;
    }

    public int getRefresh() {
        return refresh;
    }

    public void setRefresh(int refresh) {
        this.refresh = refresh;
    }
}
