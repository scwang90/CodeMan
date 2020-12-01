package ${packageName};

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.web.context.WebApplicationContext;

/**
 * 单元测试基类
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@RunWith(SpringRunner.class)
@SpringBootTest
@WebAppConfiguration
public class ${projectName}ApplicationTests {

    @Autowired
    protected WebApplicationContext context;

    @Before
    public void before() {
        System.out.println("开始测试-----------------");
    }

    @After
    public void after() {
        System.out.println("测试结束-----------------");
    }

    @Test
    public void test() {
    }

}
