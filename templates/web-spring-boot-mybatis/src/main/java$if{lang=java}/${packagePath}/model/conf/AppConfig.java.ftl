package ${packageName}.model.conf;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * 配置模型 - 文档、错误、客户端
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Data
@Component
@ConfigurationProperties(prefix = "app")
public class AppConfig {

    private Error error = new Error();
    private Client client = new Client();
    private Swagger swagger = new Swagger();

    public String getVisitHost() {
        return client.visitHost;
    }

    public String getSwaggerHost() {
        return swagger.host;
    }

    public void setSwaggerHost(String host) {
        this.swagger.host = host;
    }

    public boolean isOriginalError() {
        return error.original;
    }

    @Data
    public static class Client {
        private String visitHost;
    }
    @Data
    public static class Error {
        private boolean original = false;
    }
    @Data
    public static class Swagger {
        /**
         * 代理主机地址
         */
        private String host = "";
        /**
         * 是否启用代理
         */
        private boolean enabled = false;
    }
}
