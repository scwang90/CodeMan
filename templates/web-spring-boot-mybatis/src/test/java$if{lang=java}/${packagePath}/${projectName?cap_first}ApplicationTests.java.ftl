package ${packageName};

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.web.context.WebApplicationContext;

/**
 * 单元测试基类
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@SpringBootTest
public class ${projectName?cap_first}ApplicationTests {

    @Autowired
    protected WebApplicationContext context;


    @BeforeEach
    public final void performBefore()<#if hasLogin> throws Exception</#if> {
        before();
    }

    @AfterEach
    public final void perforAfter()<#if hasLogin> throws Exception</#if> {
        after();
    }

    protected void before()<#if hasLogin> throws Exception</#if> {
        System.out.println("开始测试-----------------");
    }

    protected void after()<#if hasLogin> throws Exception</#if> {
        System.out.println("测试结束-----------------");
    }

    @Test
    public void test() {
    }

}
