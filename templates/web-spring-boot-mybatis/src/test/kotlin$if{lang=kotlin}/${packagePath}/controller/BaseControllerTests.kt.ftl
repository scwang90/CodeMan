package ${packageName}.controller

import ${packageName}.${projectName?cap_first}ApplicationTests

<#if hasLogin>
import org.apache.shiro.spring.web.ShiroFilterFactoryBean
</#if>
import org.junit.jupiter.api.Disabled
import org.springframework.test.web.servlet.MockMvc
<#if hasLogin>
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post
import org.springframework.test.web.servlet.result.MockMvcResultMatchers.status
import org.springframework.test.web.servlet.setup.DefaultMockMvcBuilder
</#if>
import org.springframework.test.web.servlet.setup.MockMvcBuilders

<#if hasLogin>
import javax.servlet.Filter
</#if>
import javax.servlet.http.Cookie

/**
 * 单元测试基类 - Mapper
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Disabled
class BaseControllerTests : ${projectName?cap_first}ApplicationTests() {
<#if hasLogin>

    protected lateinit var mockMvc: MockMvc
    protected lateinit var factory: ShiroFilterFactoryBean

    override fun before() {
        super.before()
        factory = context.getBean(ShiroFilterFactoryBean::class.java)
        mockMvc = MockMvcBuilders.webAppContextSetup(context).addFilters<DefaultMockMvcBuilder>(factory.getObject() as Filter).build()
    }

    /**
    * 获取登入信息cookie
    */
    fun getLoginCookie(): Array<Cookie> {
        // mock request get login session
        return mockMvc.perform(post("/api/v1/auth/login")
            .param("username","admin")
            .param("password","admin"))
            .andExpect(status().isOk)
            .andReturn().response.cookies
    }
<#else >

    protected lateinit var mockMvc: MockMvc

    override fun before() {
        super.before()
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build()
    }
</#if>

}
