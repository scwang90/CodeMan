package ${packageName}.shiro;

/**
 * Jwt 凭证持有者信息
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public class JwtBearer {

    public final String userId;
    public final String userName;

    public JwtBearer(String userId, String userName) {
        this.userId = userId;
        this.userName = userName;
    }

}
