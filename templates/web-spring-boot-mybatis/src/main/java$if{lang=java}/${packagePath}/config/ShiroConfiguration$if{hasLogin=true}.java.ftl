package ${packageName}.config;

import com.auth0.jwt.algorithms.Algorithm;
import ${packageName}.model.conf.AuthTokenConfig;
import ${packageName}.shiro.filter.JwtAuthFilter;
import ${packageName}.shiro.realm.AuthRealm;
import org.apache.shiro.mgt.DefaultSubjectDAO;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.mgt.SessionStorageEvaluator;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.subject.SubjectContext;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.apache.shiro.web.mgt.DefaultWebSessionStorageEvaluator;
import org.apache.shiro.web.mgt.DefaultWebSubjectFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.servlet.Filter;
import java.io.UnsupportedEncodingException;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Shiro 配置类
 * 包括过滤页面列表、 JWT Hash 配置
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Configuration
public class ShiroConfiguration {

    public static final String SECRET_KEY = "?::4343fdf4fdf6cvf):";

    private final AuthTokenConfig tokenConfig;

    public ShiroConfiguration(AuthTokenConfig tokenConfig) {
        this.tokenConfig = tokenConfig;
    }

    @Bean
    public Algorithm jwtAlgorithm() throws Exception {
        return Algorithm.HMAC256(SECRET_KEY);
    }
    /**
     * JWT禁用session, 不保存用户登录状态。保证每次请求都重新认证。
     * 需要注意的是，如果用户代码里调用 Subject.getSession() 还是可以用session，
     * 如果要完全禁用，要配合下面的noSessionCreation的Filter来实现
     */
    @Bean
    public SessionStorageEvaluator sessionStorageEvaluator() {
        DefaultWebSessionStorageEvaluator sessionStorageEvaluator = new DefaultWebSessionStorageEvaluator();
        sessionStorageEvaluator.setSessionStorageEnabled(false);
        return sessionStorageEvaluator;
    }

    @Bean
    public SecurityManager securityManager(@Qualifier("authRealm") AuthRealm realm, @Qualifier("sessionStorageEvaluator") SessionStorageEvaluator sessionStorageEvaluator) {
        DefaultWebSecurityManager securityManager = new DefaultWebSecurityManager();
        securityManager.setRealm(realm);

        securityManager.setSubjectDAO(new DefaultSubjectDAO(){{
            this.setSessionStorageEvaluator(new DefaultWebSessionStorageEvaluator(){{
                setSessionStorageEnabled(false);
            }});
        }});
        securityManager.setSubjectFactory(new DefaultWebSubjectFactory() {
            @Override
            public Subject createSubject(SubjectContext context) {
                context.setSessionCreationEnabled(false);
                return super.createSubject(context);
            }
        });
        return securityManager;
    }


    @Bean
    public ShiroFilterFactoryBean shiroFilterFactoryBean(SecurityManager securityManager) {
        ShiroFilterFactoryBean bean = new ShiroFilterFactoryBean();

        bean.setLoginUrl("/api/v1/auth/login");
        bean.setUnauthorizedUrl("/api/v1/auth/failed");
        bean.setSecurityManager(securityManager);
        bean.setFilterChainDefinitionMap(buildChainMap());
        bean.getFilters().put("authJwt", buildJwtFilter());
        return bean;
    }

    private Map<String, String> buildChainMap() {
        Map<String, String> chain = new LinkedHashMap<>();

        Arrays.asList(
                //API
                "/api/v1/auth/**",       //login 登录认证
        ).forEach(p->chain.put(p,"anon"));

        chain.put("/api/**", "authJwt");
        return chain;
    }

    private Filter buildJwtFilter() {
        try {
            return new JwtAuthFilter(Algorithm.HMAC256(SECRET_KEY), tokenConfig);
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }
    }

}
