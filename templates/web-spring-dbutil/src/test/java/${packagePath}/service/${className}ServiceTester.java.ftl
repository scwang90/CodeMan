package ${packageName}.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import ${packageName}.model.${className};
import ${packageName}.util.JacksonUtil;

/**
 * ${table.remark}的Service层测试类
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring-*.xml")
public class ${className}ServiceTester {

	@Autowired
	${className}Service service;
	
	@Test
	public void insert() throws Exception{
		${className} model = new ${className}();
		Object result = service.insert(model);
		System.out.println(JacksonUtil.toJson(result).replace("{","\n{"));
	}
	
	@Test
	public void update() throws Exception {
		${className} model = new ${className}();
		Object result = service.update(model);
		System.out.println(JacksonUtil.toJson(result).replace("{","\n{"));
	}
	
	@Test
	public void delete() throws Exception {
		Object result = service.delete("1");
		System.out.println(JacksonUtil.toJson(result).replace("{","\n{"));
	}
	
	@Test
	public void countAll() throws Exception {
		Object result = service.countAll();
		System.out.println(JacksonUtil.toJson(result).replace("{","\n{"));
	}

	@Test
	public void findByPage() throws Exception {
		Object result = service.findByPage(5, 0);
		System.out.println(JacksonUtil.toJson(result).replace("{","\n{"));
	}

}
