package ${packageName}

import org.junit.After
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.mock.web.MockHttpSession
import org.springframework.test.context.junit4.SpringRunner
import org.springframework.test.context.web.WebAppConfiguration
import org.springframework.test.web.servlet.MockMvc
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post
import org.springframework.test.web.servlet.result.MockMvcResultMatchers.status
import org.springframework.test.web.servlet.setup.MockMvcBuilders
import org.springframework.web.context.WebApplicationContext

/**
 * 单元测试基类
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@RunWith(SpringRunner::class)
@SpringBootTest
@WebAppConfiguration
class ${projectName?cap_first}ApplicationTests {

    @Autowired
    private lateinit var context: WebApplicationContext

    protected lateinit var mockMvc: MockMvc

    @Before
    fun before() {
        println("开始测试-----------------")
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build()
    }

    @After
    fun  after() {
        println("测试结束-----------------")
    }

    /**
     * 获取登入信息session
     */
    @Throws(Exception::class)
    fun getLoginSession(): MockHttpSession {
        // mock request get login session
        return mockMvc.perform(post("/api/v1/auth/login")
                .param("username","admin")
                .param("password","admin"))
                .andExpect(status().isOk)
                .andReturn().request.session as MockHttpSession
    }

    @Test
    fun test() {

    }

}
