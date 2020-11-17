package ${packageName}.shiro.filter;

import ${packageName}.mapper.common.AuthUserMapper;
import ${packageName}.shiro.config.RestPathMatchingFilterChainResolver;
import ${packageName}.support.SpringContextHolder;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.filter.mgt.DefaultFilterChainManager;
import org.apache.shiro.web.servlet.AbstractShiroFilter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;

import javax.servlet.Filter;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 *  Filter 管理器
 */
@Component
public class ShiroFilterChainManager {

    private static final Logger LOGGER = LoggerFactory.getLogger(ShiroFilterChainManager.class);

    private final StringRedisTemplate redisTemplate;
    private final AuthUserMapper authUserMapper;

    @Autowired
    public ShiroFilterChainManager(StringRedisTemplate redisTemplate, AuthUserMapper authUserMapper){
        this.redisTemplate = redisTemplate;
        this.authUserMapper = authUserMapper;
    }

    /**
     * description 初始化获取过滤链
     *
     * @return java.util.Map<java.lang.String,javax.servlet.Filter>
     */
    public Map<String,Filter> initGetFilters() {
        Map<String,Filter> filters = new LinkedHashMap<>();
        PasswordFilter passwordFilter = new PasswordFilter();
        passwordFilter.setRedisTemplate(redisTemplate);
        filters.put("auth",passwordFilter);
        BonJwtFilter jwtFilter = new BonJwtFilter();
        jwtFilter.setRedisTemplate(redisTemplate);
        jwtFilter.setAuthUserMapper(authUserMapper);
        filters.put("jwt",jwtFilter);
        return filters;
    }
    /**
     * description 初始化获取过滤链规则
     *
     * @return java.util.Map<java.lang.String,java.lang.String>
     */
    public Map<String,String> initGetFilterChain() {

        Map<String,String> filterChain = new LinkedHashMap<>();
        // -------------anon 默认过滤器忽略的URL
        List<String> defaultAnon = Arrays.asList(
                "/css/**",
                "/js/**");
        defaultAnon.forEach(ignored -> filterChain.put(ignored, "anon"));

        // -------------auth 默认需要认证过滤器的URL 走auth--PasswordFilter
        // 正式生成环境需要权限检查： "/account/**", "/credit/**"。开发阶段只开account
        List<String> defaultAuth = Arrays.asList("/api/v1/account/login");
        defaultAuth.forEach(auth -> filterChain.put(auth, "auth"));

        // 其他api认证,开发阶段不启用
        List<String> defaultJwt = Arrays.asList("/api/v1/**");
        defaultJwt.forEach(auth -> filterChain.put(auth, "jwt"));
        return filterChain;
    }

    /**
     * description 动态重新加载过滤链规则
     */
    public void reloadFilterChain() {
            ShiroFilterFactoryBean shiroFilterFactoryBean = SpringContextHolder.getBean(ShiroFilterFactoryBean.class);
            AbstractShiroFilter abstractShiroFilter = null;
            try {
                abstractShiroFilter = (AbstractShiroFilter)shiroFilterFactoryBean.getObject();
                RestPathMatchingFilterChainResolver filterChainResolver = (RestPathMatchingFilterChainResolver)abstractShiroFilter.getFilterChainResolver();
                DefaultFilterChainManager filterChainManager = (DefaultFilterChainManager)filterChainResolver.getFilterChainManager();
                filterChainManager.getFilterChains().clear();
                shiroFilterFactoryBean.getFilterChainDefinitionMap().clear();
                shiroFilterFactoryBean.setFilterChainDefinitionMap(this.initGetFilterChain());
                shiroFilterFactoryBean.getFilterChainDefinitionMap().forEach((k,v) -> filterChainManager.createChain(k,v));
            } catch (Exception e) {
                LOGGER.error(e.getMessage(),e);
            }
    }
}
