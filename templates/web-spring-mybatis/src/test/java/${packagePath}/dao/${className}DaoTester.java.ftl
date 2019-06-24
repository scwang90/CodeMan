package ${packageName}.dao;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import ${packageName}.model.${className};
import ${packageName}.util.JacksonUtil;

/**
 * ${table.remark}的Dao层测试类
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring-*.xml")
public class ${className}DaoTester {

	@Autowired
	${className}Dao dao;
	
	@Test
	public void insert() throws Exception{
		${className} model = new ${className}();
		Object result = dao.insert(model);
		System.out.println(JacksonUtil.toJson(result).replace("{","\n{"));
	}
	
	@Test
	public void update() throws Exception {
		${className} model = new ${className}();
		Object result = dao.update(model);
		System.out.println(JacksonUtil.toJson(result).replace("{","\n{"));
	}
	
	@Test
	public void delete() throws Exception {
		Object result = dao.delete("1");
		System.out.println(JacksonUtil.toJson(result).replace("{","\n{"));
	}
	
	@Test
	public void countAll() throws Exception {
		Object result = dao.countAll();
		System.out.println(JacksonUtil.toJson(result).replace("{","\n{"));
	}

	@Test
	public void findByPage() throws Exception {
		Object result = dao.findByPage(5,0);
		System.out.println(JacksonUtil.toJson(result).replace("{","\n{"));
	}
	
}
