package ${packageName}.controller

import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.GetMapping
import springfox.documentation.annotations.ApiIgnore
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

/**
 * url 映射
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@ApiIgnore
@Controller
class IndexController {

	@GetMapping("doc","swagger")
	fun doc(): String {
		return "redirect:/swagger-ui.html"
	}

	@GetMapping("document")
	fun document(request: HttpServletRequest, response: HttpServletResponse) {
		request.getRequestDispatcher("/swagger-ui.html").forward(request, response)
	}

	@GetMapping("admin")
	fun admin(request: HttpServletRequest, response: HttpServletResponse) {
		request.getRequestDispatcher("/admin/index.html").forward(request, response)
	}

	@GetMapping("admin/{*:[\\w\\-]+}","admin/{*:[\\w\\-]+}/{*:[\\w\\-]+}","admin/{*:[\\w\\-]+}/{*:[\\w\\-]+}/{*:[\\w\\-]+}")
	fun admin404(request: HttpServletRequest, response: HttpServletResponse) {
		request.getRequestDispatcher("/admin/index.html").forward(request, response)
	}

//    @GetMapping("admin")
//    fun home(): String {
//    	return "redirect:/admin/index"
//    }
//
//	  @GetMapping("admin/index")
//	  fun index(model: Model, request: HttpServletRequest): String {
//	  	return "index"
//	  }
//
//	  @GetMapping("admin/login")
//	  fun login(model: Model, request: HttpServletRequest): String {
//	  	return "login"
//	  }
//
    <#list tables as table>
//    @GetMapping("admin/manager/${table.urlPathName}")
//    fun ${table.classNameCamel}(model: Model, request: HttpServletRequest): String {
//    	return "manager/${table.urlPathName}"
//    }
    </#list>
}