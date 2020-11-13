package ${packageName}.shiro.provider;

//import ${packageName}.mapper.common.AuthUserMapper;
//import ${packageName}.his.model.db.User;
import ${packageName}.shiro.Account;
import ${packageName}.shiro.provider.AccountProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

/**
 * 账户适配器
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Service("AccountProvider")
public class AccountProviderImpl implements AccountProvider {

    //@Autowired
    //@Qualifier("AuthUserMapper")
    //private AuthUserMapper authUserMapper;

    @Override
    public Account loadAccount(String appId) {
        //User user = authUserMapper.getUserByUserName(appId);
        //if (user == null) {
            return null;
        //}
        //return new Account(user.getUserAccount(), user.getUserPassword(), "");
    }
}
