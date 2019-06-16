package ${packageName};

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * 单元测试基类
 * @author ${author}
 * @date ${.now?string("yyyy-MM-dd zzzz")}
 */
@RunWith(SpringRunner.class)
@SpringBootTest
@WebAppConfiguration
public class ${projectName}ApplicationTests {

    @Autowired
    private WebApplicationContext context;

    protected MockMvc mockMvc;

    @Before
    public void before() {
        System.out.println("开始测试-----------------");
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @After
    public void after() {
        System.out.println("测试结束-----------------");
    }

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

    @Test
    public void test() {

    }

}
