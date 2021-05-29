package ${packageName}.config

import com.auth0.jwt.algorithms.Algorithm
import ${packageName}.model.conf.AuthConfig
import ${packageName}.shiro.AuthRealm
import ${packageName}.shiro.JwtAuthFilter
import org.apache.shiro.mgt.DefaultSubjectDAO
import org.apache.shiro.mgt.SecurityManager
import org.apache.shiro.mgt.SessionStorageEvaluator
import org.apache.shiro.spring.web.ShiroFilterFactoryBean
import org.apache.shiro.subject.Subject
import org.apache.shiro.subject.SubjectContext
import org.apache.shiro.web.mgt.DefaultWebSecurityManager
import org.apache.shiro.web.mgt.DefaultWebSessionStorageEvaluator
import org.apache.shiro.web.mgt.DefaultWebSubjectFactory
import org.springframework.beans.factory.annotation.Qualifier
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration

/**
 * Shiro 配置类
 * 包括过滤页面列表、 JWT Hash 配置
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Configuration
class ShiroConfiguration(private val authConfig: AuthConfig) {

    @Bean
    @Throws(Exception::class)
    fun jwtAlgorithm(): Algorithm {
        return Algorithm.HMAC256(SECRET_KEY)
    }

    /**
     * JWT禁用session, 不保存用户登录状态。保证每次请求都重新认证。
     * 需要注意的是，如果用户代码里调用 Subject.getSession() 还是可以用session，
     * 如果要完全禁用，要配合下面的noSessionCreation的Filter来实现
     */
    @Bean
    fun sessionStorageEvaluator(): SessionStorageEvaluator {
        val sessionStorageEvaluator = DefaultWebSessionStorageEvaluator()
        //JWT禁用session, 不保存用户登录状态。保证每次请求都重新认证。
        sessionStorageEvaluator.isSessionStorageEnabled = false
        return sessionStorageEvaluator
    }

    /**
     * JWT禁用session, 不保存用户登录状态。保证每次请求都重新认证。
     * 需要注意的是，如果用户代码里调用 Subject.getSession() 还是可以用session，
     * 如果要完全禁用，要配合下面的noSessionCreation的Filter来实现
     */
    @Bean
    fun securityManager(realm: AuthRealm, @Qualifier("sessionStorageEvaluator") sessionStorageEvaluator: SessionStorageEvaluator?): SecurityManager {
        val securityManager = DefaultWebSecurityManager()
        securityManager.setRealm(realm)
        securityManager.subjectDAO = object : DefaultSubjectDAO() {
            init {
                this.sessionStorageEvaluator = object : DefaultWebSessionStorageEvaluator() {
                    init {
                        //JWT禁用session, 不保存用户登录状态。保证每次请求都重新认证。
                        isSessionStorageEnabled = false
                    }
                }
            }
        }
        securityManager.subjectFactory = object : DefaultWebSubjectFactory() {
            override fun createSubject(context: SubjectContext): Subject {
                //JWT禁用session, 不保存用户登录状态。保证每次请求都重新认证。
                context.isSessionCreationEnabled = false
                return super.createSubject(context)
            }
        }
        return securityManager
    }

    @Bean
    fun shiroFilterFactoryBean(securityManager: SecurityManager): ShiroFilterFactoryBean {
        val bean = ShiroFilterFactoryBean()
        bean.loginUrl = "/api/v1/auth/login"
        bean.unauthorizedUrl = "/api/v1/auth/failed"
        bean.securityManager = securityManager
        bean.filterChainDefinitionMap = buildChainMap()
        bean.filters["jwt"] = JwtAuthFilter(Algorithm.HMAC256(SECRET_KEY), authConfig)
        return bean
    }

    private fun buildChainMap(): Map<String, String> {
        val chain: MutableMap<String, String> = LinkedHashMap()

        /*
         * 配置非登录路由
         */
        listOf( //API
            "/api/v1/auth/**",  //login 登录
            "/api/v1/file/download/**", //文件下载
        ).forEach { p: String -> chain[p] = "anon" }
        /*
         * 配置 JWT 认证路由
         */
        chain["/api/**"] = "jwt"
        return chain
    }

    companion object {
        const val SECRET_KEY = "?::4343fdf4fdf6cvf):"
    }
}