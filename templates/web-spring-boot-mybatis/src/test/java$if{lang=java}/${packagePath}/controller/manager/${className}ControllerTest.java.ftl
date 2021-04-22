package ${packageName}.controller.manager;

import ${packageName}.controller.BaseControllerTests;

import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import static org.springframework.http.MediaType.APPLICATION_JSON;
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
@Disabled
@DisplayName("【${table.remarkName}】的Controller层测试类")
public class ${className}ControllerTest extends BaseControllerTests {

	@Test
	@Disabled
	@DisplayName("列表测试方法")
    public void list() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.get("/api/v1/${table.urlPathName}")
				.accept(APPLICATION_JSON)
<#if hasLogin>
				.cookie(getLoginCookie()))
</#if>
				.andExpect(status().isOk())
				.andExpect(content().contentType(APPLICATION_JSON))
				.andDo(print());
	}

	@Test
	@Disabled
	@DisplayName("插入测试方法")
    public void insert() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.post("/api/v1/${table.urlPathName}")
				.accept(APPLICATION_JSON)
<#if hasLogin>
				.cookie(getLoginCookie()))
</#if>
				.andExpect(status().isOk())
				.andExpect(content().contentType(APPLICATION_JSON))
				.andDo(print());
	}

	@Test
	@Disabled
	@DisplayName("更新测试方法")
    public void update() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.put("/api/v1/${table.urlPathName}")
				.accept(APPLICATION_JSON)
<#if hasLogin>
				.cookie(getLoginCookie()))
</#if>
				.andExpect(status().isOk())
				.andExpect(content().contentType(APPLICATION_JSON))
				.andDo(print());
	}

	@Test
	@Disabled
	@DisplayName("获取测试方法")
    public void get() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.get("/api/v1/${table.urlPathName}/{id}")
				.accept(APPLICATION_JSON)
<#if hasLogin>
				.cookie(getLoginCookie()))
</#if>
				.andExpect(status().isOk())
				.andExpect(content().contentType(APPLICATION_JSON))
				.andDo(print());
	}

	@Test
	@Disabled
	@DisplayName("删除测试方法")
    public void delete() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.delete("/api/v1/${table.urlPathName}/{id}")
				.accept(APPLICATION_JSON)
<#if hasLogin>
				.cookie(getLoginCookie()))
</#if>
				.andExpect(status().isOk())
				.andExpect(content().contentType(APPLICATION_JSON))
				.andDo(print());
	}

}
