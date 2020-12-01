package ${packageName}.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import springfox.documentation.annotations.ApiIgnore;

/**
* url 映射
* @author ${author}
* @since ${now?string("yyyy-MM-dd zzzz")}
*/
@ApiIgnore
@Controller
public class IndexController {

	@RequestMapping({"doc","swagger"})
    public String doc() {
		return "redirect:/swagger-ui.html";
	}

	@RequestMapping("document")
    public void document(HttpServletRequest request , HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/swagger-ui.html").forward(request, response);
	}

	@RequestMapping("admin")
    public String home() {
		return "redirect:/admin/index";
	}

	@RequestMapping("admin/index")
    public String index(Model model) {
		return "index";
	}

	@RequestMapping("admin/login")
    public String login(Model model) {
		return "login";
	}

    <#list tables as table>
    //数据库【${table.name}】表
	@RequestMapping("admin/manager/${table.urlPathName}")
    public String ${table.classNameCamel}() {
		return "manager/${table.urlPathName}";
	}
    </#list>
}
