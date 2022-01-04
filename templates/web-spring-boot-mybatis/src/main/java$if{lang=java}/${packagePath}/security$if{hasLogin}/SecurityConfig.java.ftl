package ${packageName}.security;

import ${packageName}.model.conf.AuthConfig;
import com.auth0.jwt.algorithms.Algorithm;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.AllArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

/**
 * Spring Security 配置累
 *
 * 由代码生成器生成，可以修改
 * 但是如果删除，下次继续生成时，又会出现
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Configuration
@EnableWebSecurity
@AllArgsConstructor
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    private final AuthConfig authConfig;
    private final ObjectMapper objectMapper;

    public static final String SECRET_KEY = "?::4343fdf4fdf6cvf):";

    @Bean
    public Algorithm jwtAlgorithm() throws Exception {
        return Algorithm.HMAC256(SECRET_KEY);
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        Algorithm jwtAlgorithm = jwtAlgorithm();

        http.exceptionHandling()
                //未授权处理
                .authenticationEntryPoint(new UnauthorizedEntryPoint(objectMapper))
                .and().authorizeRequests()
                .antMatchers(
                    "/api/v1/auth/login",
                    "/version","/doc",
                    "/doc.html","/swagger-ui.html",
                    "/webjars/**","/swagger-resources/**","/v2/api-docs"
                ).permitAll()
                .anyRequest().authenticated()
                .and().csrf().disable()// 禁用 Spring Security 自带的跨域处理
                // 定制我们自己的 session 策略：调整为让 Spring Security 不创建和使用 session
                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS);

        http.addFilterBefore(new JwtVerifyFilter(authenticationManagerBean(), jwtAlgorithm, authConfig), UsernamePasswordAuthenticationFilter.class);
    }

}
