package ${packageName}.shiro;

/**
 * Jwt 凭证持有者信息
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public class JwtBearer {

    public final ${loginTable.idColumn.fieldType} userId;
    public final String userName;

    public JwtBearer(${loginTable.idColumn.fieldType} userId, String userName) {
        this.userId = userId;
        this.userName = userName;
    }

}
