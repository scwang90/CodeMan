package ${packageName}.controller;

import ${packageName}.${projectName?cap_first}ApplicationTests;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * 单元测试基类 - Mapper
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public class BaseControllerTests extends ${projectName?cap_first}ApplicationTests {

    protected MockMvc mockMvc;

    public void before() {
        super.before();
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

<#if hasLogin>

    /**
    * 获取登入信息session
    */
    public MockHttpSession getLoginSession() throws Exception {
        // mock request get login session
        return (MockHttpSession)mockMvc.perform(post("/api/v1/auth/login")
        .param("username","admin")
        .param("password","admin"))
        .andExpect(status().isOk())
        .andReturn().getRequest().getSession();
    }
</#if>
}
