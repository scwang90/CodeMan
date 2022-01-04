package ${packageName};

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * SpringBoot 程序入口
 *
 * 由代码生成器生成，可以修改
 * 但是如果删除，下次继续生成时，又会出现
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@SpringBootApplication
public class ${projectClassName}Application {

    public static void main(String[] args) {
        SpringApplication.run(${projectClassName}Application.class, args);
    }

}
