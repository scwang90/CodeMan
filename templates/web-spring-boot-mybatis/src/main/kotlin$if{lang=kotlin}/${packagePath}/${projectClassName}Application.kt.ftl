package ${packageName}

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import java.util.*

/**
 * SpringBoot 程序入口
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Configuration
@SpringBootApplication
class ${projectClassName}Application {

    /**
     * 所有产生随机数到地方都使用同一个随机数生成器，优化生成器的随机性
     */
    @Bean
    fun random(): Random {
        return Random()
    }

}

fun main(args: Array<String>) {
    runApplication<${projectClassName}Application>(*args)
}
