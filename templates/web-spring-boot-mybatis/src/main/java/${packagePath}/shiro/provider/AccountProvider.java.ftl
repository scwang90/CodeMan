package ${packageName}.shiro.provider;

import ${packageName}.shiro.Account;

/**
 * 数据库用户密码账户提供
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public interface AccountProvider {

    /**
     * description 数据库用户密码账户提供
     *
     * @param appId 1
     * @return com.fecred.credit.china.model.api.Account
     */
    Account loadAccount(String appId);

}
