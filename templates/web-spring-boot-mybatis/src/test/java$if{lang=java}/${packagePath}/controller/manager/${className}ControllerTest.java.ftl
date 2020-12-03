package ${packageName}.controller.manager;

import ${packageName}.controller.BaseControllerTests;

import org.junit.Ignore;
import org.junit.Test;

import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import static org.springframework.http.MediaType.APPLICATION_JSON_UTF8;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * ${table.remark} 的 Controller 单元测试
<#list table.descriptions as description>
 * ${description}
</#list>
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Ignore
public class ${className}ControllerTest extends BaseControllerTests {

	@Test
	@Ignore
    public void list() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.get("/api/v1/${table.urlPathName}")
<#if hasLogin>
				.accept(APPLICATION_JSON_UTF8)
				.session(getLoginSession()))
<#else>
				.accept(APPLICATION_JSON_UTF8))
</#if>
				.andExpect(status().isOk())
				.andExpect(content().contentType(APPLICATION_JSON_UTF8))
				.andDo(print());
	}

	@Test
	@Ignore
    public void insert() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.post("/api/v1/${table.urlPathName}")
<#if hasLogin>
				.accept(APPLICATION_JSON_UTF8)
				.session(getLoginSession()))
<#else>
				.accept(APPLICATION_JSON_UTF8))
</#if>
				.andExpect(status().isOk())
				.andExpect(content().contentType(APPLICATION_JSON_UTF8))
				.andDo(print());
	}

	@Test
	@Ignore
    public void update() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.put("/api/v1/${table.urlPathName}")
<#if hasLogin>
				.accept(APPLICATION_JSON_UTF8)
				.session(getLoginSession()))
<#else>
				.accept(APPLICATION_JSON_UTF8))
</#if>
				.andExpect(status().isOk())
				.andExpect(content().contentType(APPLICATION_JSON_UTF8))
				.andDo(print());
	}

	@Test
	@Ignore
    public void get() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.get("/api/v1/${table.urlPathName}/{id}")
<#if hasLogin>
				.accept(APPLICATION_JSON_UTF8)
				.session(getLoginSession()))
<#else>
				.accept(APPLICATION_JSON_UTF8))
</#if>
				.andExpect(status().isOk())
				.andExpect(content().contentType(APPLICATION_JSON_UTF8))
				.andDo(print());
	}

	@Test
	@Ignore
    public void delete() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.delete("/api/v1/${table.urlPathName}/{id}")
<#if hasLogin>
				.accept(APPLICATION_JSON_UTF8)
				.session(getLoginSession()))
<#else>
				.accept(APPLICATION_JSON_UTF8))
</#if>
				.andExpect(status().isOk())
				.andExpect(content().contentType(APPLICATION_JSON_UTF8))
				.andDo(print());
	}

}
