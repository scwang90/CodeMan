package ${packageName}.model.conf;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * 配置模型 - 文档、错误、客户端
 *
 * 由代码生成器生成，可以修改
 * 但是如果删除，下次继续生成时，又会出现
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
    private CorsConfig cors = new CorsConfig();
    private AutoConfig auto = new AutoConfig();

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
    public static class AutoConfig {
        private boolean apiDisable = true;
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

    @Data
    public static class CorsConfig {
        private String mappging = "/api/**";
        private String allowedMethods = "*";
        private boolean allowCredentials = true;
        private String exposedHeaders = "x-auth-token;Content-Type";
        private String allowedOriginPatterns = "*localhost*;*127.0.0.1*;*0.0.0.0*";
    }
}
