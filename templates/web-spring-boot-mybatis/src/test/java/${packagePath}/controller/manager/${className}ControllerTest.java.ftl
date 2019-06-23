package ${packageName}.controller.manager;

import ${packageName}.${projectName}ApplicationTests;

import org.junit.Ignore;
import org.junit.Test;

import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import static org.springframework.http.MediaType.APPLICATION_JSON_UTF8;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;


public class ${className}ControllerTest extends ${projectName}ApplicationTests {

	@Test
    public void list() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.get("/api/v1/${table.urlPathName}")
				.accept(APPLICATION_JSON_UTF8)
				.session(getLoginSession()))
				.andExpect(status().isOk())
				.andExpect(content().contentType(APPLICATION_JSON_UTF8))
				.andDo(print());
	}

	@Ignore
	@Test
    public void insert() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.post("/api/v1/${table.urlPathName}")
				.accept(APPLICATION_JSON_UTF8)
				.session(getLoginSession()))
				.andExpect(status().isOk())
				.andExpect(content().contentType(APPLICATION_JSON_UTF8))
				.andDo(print());
	}

	@Ignore
	@Test
    public void update() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.put("/api/v1/${table.urlPathName}")
				.accept(APPLICATION_JSON_UTF8)
				.session(getLoginSession()))
				.andExpect(status().isOk())
				.andExpect(content().contentType(APPLICATION_JSON_UTF8))
				.andDo(print());
	}

	@Ignore
	@Test
    public void get() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.get("/api/v1/${table.urlPathName}/{id}")
				.accept(APPLICATION_JSON_UTF8)
				.session(getLoginSession()))
				.andExpect(status().isOk())
				.andExpect(content().contentType(APPLICATION_JSON_UTF8))
				.andDo(print());
	}

	@Ignore
	@Test
    public void delete() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.delete("/api/v1/${table.urlPathName}/{id}")
				.accept(APPLICATION_JSON_UTF8)
				.session(getLoginSession()))
				.andExpect(status().isOk())
				.andExpect(content().contentType(APPLICATION_JSON_UTF8))
				.andDo(print());
	}

}