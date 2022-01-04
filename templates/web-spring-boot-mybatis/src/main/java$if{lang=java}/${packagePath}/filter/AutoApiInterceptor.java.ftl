package ${packageName}.filter;

import ${packageName}.exception.ClientException;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 自动生成API拦截器
 * 代码生成器为每张表生成了一些列的增删查改接口，存放在 auto 包中
 * 这些接口主要用于生成器生成项目初期演示，和开发时复制可用代码用的
 * 这些接口拥有最高的数据库权限，可以轻易删除任何数据，所以项目上线，这些接口需要被拦截
 * 本拦截器就主要用于拦截 auto 包中的所有接口
 *
 * 由代码生成器生成，可以修改
 * 但是如果删除，下次继续生成时，又会出现
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public class AutoApiInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        throw new ClientException("接口已经被禁止访问");
    }
}
