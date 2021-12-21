package ${packageName};

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * SpringBoot 程序入口
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@SpringBootApplication
public class ${projectClassName}Application {

    public static void main(String[] args) {
        SpringApplication.run(${projectClassName}Application.class, args);
    }

}
