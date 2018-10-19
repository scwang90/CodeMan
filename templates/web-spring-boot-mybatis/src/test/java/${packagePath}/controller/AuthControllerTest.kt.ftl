package ${packageName}.controller.manager

import ${packageName}.${projectName}ApplicationTests
import org.junit.Test
import org.springframework.http.MediaType.APPLICATION_FORM_URLENCODED
import org.springframework.http.MediaType.APPLICATION_JSON_UTF8
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post
import org.springframework.test.web.servlet.result.MockMvcResultHandlers.print
import org.springframework.test.web.servlet.result.MockMvcResultMatchers.content
import org.springframework.test.web.servlet.result.MockMvcResultMatchers.status

class ${className}ManagerControllerTest : ${projectName}ApplicationTests() {

	@Test
	fun login() {
		mockMvc.perform(post("/api/v1/auth/login")
				.param("username", "admin")
				.param("password", "admin")
				.accept(APPLICATION_JSON_UTF8))
				.andExpect(status().isOk)
				.andExpect(content().contentType(APPLICATION_JSON_UTF8))
				.andDo(print())
	}

	@Test
	fun logout() {
		mockMvc.perform(get("/api/v1/auth/logout")
				.accept(APPLICATION_JSON_UTF8)
				.session(getLoginSession()))
				.andExpect(status().isOk)
				.andExpect(content().contentType(APPLICATION_JSON_UTF8))
				.andDo(print())
	}

	@Test
	fun failed() {
		mockMvc.perform(get("/api/v1/auth/failed")
				.accept(APPLICATION_JSON_UTF8))
				.andExpect(status().isOk)
				.andExpect(content().contentType(APPLICATION_JSON_UTF8))
				.andDo(print())
	}

}