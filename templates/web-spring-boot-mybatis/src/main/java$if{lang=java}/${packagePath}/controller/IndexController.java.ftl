package ${packageName}.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import springfox.documentation.annotations.ApiIgnore;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * url 映射
 * 由代码生成器生成，可以修改
 * 但是如果删除，下次继续生成时，又会出现
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@ApiIgnore
@Controller
public class IndexController {

	@GetMapping({"doc","swagger"})
    public String doc() {
		return "redirect:/swagger-ui.html";
	}

	@GetMapping("back")
	public String admin() {
		return "redirect:/admin";
	}

	@ResponseBody
	@GetMapping("version")
	public String version() {
		String version = IndexController.class.getPackage().getImplementationVersion();
		return version != null ? version : "调试版本";
	}

	@GetMapping("document")
    public void document(HttpServletRequest request , HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/swagger-ui.html").forward(request, response);
	}

//	@GetMapping("admin")
//	public void admin(HttpServletRequest request , HttpServletResponse response) throws ServletException, IOException {
//		request.getRequestDispatcher("/admin/index.html").forward(request, response);
//	}
//
//	@GetMapping({"admin/{*:[\\w\\-]+}","admin/{*:[\\w\\-]+}/{*:[\\w\\-]+}","admin/{*:[\\w\\-]+}/{*:[\\w\\-]+}/{*:[\\w\\-]+}"})
//	public void admin404(HttpServletRequest request , HttpServletResponse response) throws ServletException, IOException {
//		//LoggerFactory.getLogger("admin404").info("path=" + request.servletPath);
//		request.getRequestDispatcher("/admin/index.html").forward(request, response);
//	}

//	  @GetMapping("admin")
//    public String home() {
//		  return "redirect:/admin/index";
//    }
//
//	  @GetMapping("admin/index")
//    public String index(Model model) {
//		  return "index";
//    }
//
//	  @GetMapping("admin/login")
//    public String login(Model model) {
//	      return "login";
//    }
//
    <#list tables as table>
//    //数据库【${table.name}】表
//	  @GetMapping("admin/manager/${table.urlPathName}")
//    public String ${table.classNameCamel}() {
//	      return "manager/${table.urlPathName}";
//	  }
    </#list>
}
