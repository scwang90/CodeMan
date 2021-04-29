package ${packageName}.controller.manager

import ${packageName}.controller.BaseControllerTests

import org.junit.jupiter.api.Disabled
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import org.springframework.http.MediaType.APPLICATION_JSON
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*
import org.springframework.test.web.servlet.result.MockMvcResultHandlers.print
import org.springframework.test.web.servlet.result.MockMvcResultMatchers.content
import org.springframework.test.web.servlet.result.MockMvcResultMatchers.status


/**
 * ${table.remark} 的 Controller 单元测试
<#list table.descriptions as description>
 * ${description}
</#list>
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Disabled
@DisplayName("【${table.remarkName}】的Controller层测试类")
class ${className}ManagerControllerTest : BaseControllerTests() {

	@Test
	@Disabled
	@DisplayName("列表测试方法")
	fun list() {
		mockMvc.perform(get("/api/v1/${table.urlPathName}")
				.accept(APPLICATION_JSON)
<#if hasLogin>
				.cookie(*getLoginCookie()))
</#if>
				.andExpect(status().isOk)
				.andExpect(content().contentType(APPLICATION_JSON))
				.andDo(print())
	}

	@Test
	@Disabled
	@DisplayName("插入测试方法")
	fun insert() {
		mockMvc.perform(post("/api/v1/${table.urlPathName}")
				.accept(APPLICATION_JSON)
<#if hasLogin>
				.cookie(*getLoginCookie()))
</#if>
				.andExpect(status().isOk)
				.andExpect(content().contentType(APPLICATION_JSON))
				.andDo(print())
	}

	@Test
	@Disabled
	@DisplayName("更新测试方法")
	fun update() {
		mockMvc.perform(put("/api/v1/${table.urlPathName}")
				.accept(APPLICATION_JSON)
<#if hasLogin>
				.cookie(*getLoginCookie()))
</#if>
				.andExpect(status().isOk)
				.andExpect(content().contentType(APPLICATION_JSON))
				.andDo(print())
	}

	@Test
	@Disabled
	@DisplayName("获取测试方法")
	fun get() {
		mockMvc.perform(get("/api/v1/${table.urlPathName}/{id}")
				.accept(APPLICATION_JSON)
<#if hasLogin>
				.cookie(*getLoginCookie()))
</#if>
				.andExpect(status().isOk)
				.andExpect(content().contentType(APPLICATION_JSON))
				.andDo(print())
	}

	@Test
	@Disabled
	@DisplayName("删除测试方法")
	fun delete() {
		mockMvc.perform(delete("/api/v1/${table.urlPathName}/{id}")
				.accept(APPLICATION_JSON)
<#if hasLogin>
				.cookie(*getLoginCookie()))
</#if>
				.andExpect(status().isOk)
				.andExpect(content().contentType(APPLICATION_JSON))
				.andDo(print())
	}

}