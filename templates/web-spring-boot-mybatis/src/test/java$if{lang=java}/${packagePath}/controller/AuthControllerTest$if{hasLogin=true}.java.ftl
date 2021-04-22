package ${packageName}.controller;

import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.springframework.http.MediaType.APPLICATION_JSON;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * 登录认证 的 Controller 单元测试
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Disabled
@DisplayName("【登录认证】的Controller层测试类")
public class AuthControllerTest extends BaseControllerTests {

	@Test
    public void login() throws Exception {
		mockMvc.perform(post("/api/v1/auth/login")
				.param("username", "admin")
				.param("password", "admin")
				.accept(APPLICATION_JSON))
				.andExpect(status().isOk())
				.andExpect(content().contentType(APPLICATION_JSON))
				.andDo(print());
	}

	@Test
    public void logout() throws Exception {
		mockMvc.perform(get("/api/v1/auth/logout")
				.accept(APPLICATION_JSON)
				.cookie(getLoginCookie()))
				.andExpect(status().isOk())
				.andExpect(content().contentType(APPLICATION_JSON))
				.andDo(print());
	}

	@Test
    public void failed() throws Exception {
		mockMvc.perform(get("/api/v1/auth/failed")
				.accept(APPLICATION_JSON))
				.andExpect(status().isOk())
				.andExpect(content().contentType(APPLICATION_JSON))
				.andDo(print());
	}

}
