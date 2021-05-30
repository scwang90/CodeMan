package ${packageName}.model.conf;

import lombok.Data;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * 配置模型 - 认证相关
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Data
@Component
@ConfigurationProperties(prefix = "app.auth")
public class AuthConfig {

    private Token token = new Token();
    
    private Password password = new Password();

    public long getExpiryTime() {
        return token.expiry * 1000L;
    }

    public long getRefreshTime() {
        return token.refresh * 1000L;
    }

    public String hash(String pwd) {
        return new Md5Hash(pwd, password.salt, password.iterations).toHex();
    }

    @Data
    public static class Token {
        /**
         * 凭证有效时间 (秒钟)
         */
        private int expiry = 60;
        /**
         * 凭证刷新间隔 (秒钟)
         */
        private int refresh = 10;
    }

    @Data
    public static class Password {
        /**
         * 散列次数
         */
        private int iterations = 2;
        /**
         * 密码盐值
         */
        private String salt = "Traveler";
        /**
         * 加密算法
         */
        private String algorithm = "MD5";
    }
}
