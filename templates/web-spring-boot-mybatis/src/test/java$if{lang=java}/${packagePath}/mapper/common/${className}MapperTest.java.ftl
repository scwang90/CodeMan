package ${packageName}.mapper.common;

import com.fasterxml.jackson.databind.ObjectMapper;
import ${packageName}.mapper.common.${className}Mapper;
import ${packageName}.model.db.${className};
import ${packageName}.${projectName}ApplicationTests;

import org.apache.ibatis.session.RowBounds;
import org.junit.Ignore;
import org.junit.Test;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import java.util.List;

import static org.springframework.http.MediaType.APPLICATION_JSON_UTF8;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

public class ${className}MapperTest extends ${projectName}ApplicationTests {

	@Autowired
	private ${className}Mapper mapper;
	private final ObjectMapper json = new ObjectMapper();

	@Test
	public void list() throws Exception {
		List<${className}> models = mapper.findListWhere("", "", new RowBounds(0, 5));
		System.out.println(json.writerWithDefaultPrettyPrinter().writeValueAsString(models));
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
