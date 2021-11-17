package ${packageName}

import org.junit.jupiter.api.AfterEach
import org.junit.jupiter.api.Disabled
import org.junit.jupiter.api.BeforeEach

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.web.context.WebApplicationContext

/**
 * 单元测试基类
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Disabled
@SpringBootTest
class ${projectClassName}ApplicationTests {

    @Autowired
    protected lateinit var context: WebApplicationContext

    @BeforeEach
    fun performBefore() {
        before()
    }

    @AfterEach
    fun perforAfter() {
        after()
    }

    fun before() {
        println("开始测试-----------------")
    }

    fun after() {
        println("测试结束-----------------")
    }

}
