package ${packageName}.model.conf;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * 客户端信息配置
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Component
@ConfigurationProperties(prefix="client")
public class ClientConfig {

    private String visitHost;

    public String getVisitHost() {
        return visitHost;
    }

    public void setVisitHost(String visitHost) {
        this.visitHost = visitHost;
    }
}
