package ${packageName}.controller;

import ${packageName}.${projectName?cap_first}ApplicationTests;

<#if hasLogin>
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
</#if>
import org.junit.jupiter.api.Disabled;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

<#if hasLogin>
import javax.servlet.Filter;
</#if>
import javax.servlet.http.Cookie;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * 单元测试基类 - Mapper
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Disabled
public class BaseControllerTests extends ${projectName?cap_first}ApplicationTests {
<#if hasLogin>

    protected MockMvc mockMvc;
    protected ShiroFilterFactoryBean factory;

    public void before() throws Exception {
        super.before();
        factory = context.getBean(ShiroFilterFactoryBean.class);
        mockMvc = MockMvcBuilders.webAppContextSetup(context).addFilters((Filter)factory.getObject()).build();
    }

    /**
    * 获取登入信息cookie
    */
    public Cookie[] getLoginCookie() throws Exception {
        // mock request get login session
        return mockMvc.perform(post("/api/v1/auth/login")
            .param("username","admin")
            .param("password","admin"))
            .andExpect(status().isOk())
            .andReturn().getResponse().getCookies();
    }
<#else >

    protected MockMvc mockMvc;

    public void before() {
        super.before();
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }
</#if>

}
