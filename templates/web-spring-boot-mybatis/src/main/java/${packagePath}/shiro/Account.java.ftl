package ${packageName}.shiro;

import java.io.Serializable;

/**
 * 账户
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public class Account implements Serializable {

    private static final long serialVersionUID = 1L;

    private String appId;
    private String password;
    private String salt;

    public Account(String appId, String password, String salt) {
        this.appId = appId;
        this.password = password;
        this.salt = salt;
    }

    public String getAppId() {
        return appId;
    }

    public void setAppId(String appId) {
        this.appId = appId;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }
}
