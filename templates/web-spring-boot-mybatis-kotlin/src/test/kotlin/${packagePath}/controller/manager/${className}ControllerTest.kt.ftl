package ${packageName}.controller.manager

import ${packageName}.${projectName}ApplicationTests
import org.junit.Ignore
import org.junit.Test
import org.springframework.http.MediaType.APPLICATION_JSON_UTF8
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*
import org.springframework.test.web.servlet.result.MockMvcResultHandlers.print
import org.springframework.test.web.servlet.result.MockMvcResultMatchers.content
import org.springframework.test.web.servlet.result.MockMvcResultMatchers.status

class ${className}ManagerControllerTest : ${projectName}ApplicationTests() {

	@Test
	fun list() {
		mockMvc.perform(get("/api/v1/${table.urlPathName}")
				.accept(APPLICATION_JSON_UTF8)
				.session(getLoginSession()))
				.andExpect(status().isOk)
				.andExpect(content().contentType(APPLICATION_JSON_UTF8))
				.andDo(print())
	}

	@Ignore
	@Test
	fun insert() {
		mockMvc.perform(post("/api/v1/${table.urlPathName}")
				.accept(APPLICATION_JSON_UTF8)
				.session(getLoginSession()))
				.andExpect(status().isOk)
				.andExpect(content().contentType(APPLICATION_JSON_UTF8))
				.andDo(print())
	}

	@Ignore
	@Test
	fun update() {
		mockMvc.perform(put("/api/v1/${table.urlPathName}")
				.accept(APPLICATION_JSON_UTF8)
				.session(getLoginSession()))
				.andExpect(status().isOk)
				.andExpect(content().contentType(APPLICATION_JSON_UTF8))
				.andDo(print())
	}

	@Ignore
	@Test
	fun get() {
		mockMvc.perform(get("/api/v1/${table.urlPathName}/{id}")
				.accept(APPLICATION_JSON_UTF8)
				.session(getLoginSession()))
				.andExpect(status().isOk)
				.andExpect(content().contentType(APPLICATION_JSON_UTF8))
				.andDo(print())
	}

	@Ignore
	@Test
	fun delete() {
		mockMvc.perform(delete("/api/v1/${table.urlPathName}/{id}")
				.accept(APPLICATION_JSON_UTF8)
				.session(getLoginSession()))
				.andExpect(status().isOk)
				.andExpect(content().contentType(APPLICATION_JSON_UTF8))
				.andDo(print())
	}

}