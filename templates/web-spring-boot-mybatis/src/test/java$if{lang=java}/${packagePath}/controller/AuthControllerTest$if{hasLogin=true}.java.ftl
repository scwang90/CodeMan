package ${packageName}.controller;

import org.junit.Ignore;
import org.junit.Test;

import static org.springframework.http.MediaType.APPLICATION_JSON_UTF8;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@Ignore
public class AuthControllerTest extends BaseControllerTests {

	@Test
    public void login() throws Exception {
		mockMvc.perform(post("/api/v1/auth/login")
				.param("username", "admin")
				.param("password", "admin")
				.accept(APPLICATION_JSON_UTF8))
				.andExpect(status().isOk())
				.andExpect(content().contentType(APPLICATION_JSON_UTF8))
				.andDo(print());
	}

	@Test
    public void logout() throws Exception {
		mockMvc.perform(get("/api/v1/auth/logout")
				.accept(APPLICATION_JSON_UTF8)
				.session(getLoginSession()))
				.andExpect(status().isOk())
				.andExpect(content().contentType(APPLICATION_JSON_UTF8))
				.andDo(print());
	}

	@Test
    public void failed() throws Exception {
		mockMvc.perform(get("/api/v1/auth/failed")
				.accept(APPLICATION_JSON_UTF8))
				.andExpect(status().isOk())
				.andExpect(content().contentType(APPLICATION_JSON_UTF8))
				.andDo(print());
	}

}
