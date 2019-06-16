package ${packageName}.controller

import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.RequestMapping
import springfox.documentation.annotations.ApiIgnore
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

/**
* url 映射
* @author ${author}
* @date ${.now?string("yyyy-MM-dd zzzz")}
*/
@ApiIgnore
@Controller
class IndexController {

	@RequestMapping("doc","swagger")
	fun doc(): String {
		return "redirect:/swagger-ui.html"
	}

	@RequestMapping("document")
	fun document(request: HttpServletRequest, response: HttpServletResponse) {
		request.getRequestDispatcher("/swagger-ui.html").forward(request, response)
	}

	@RequestMapping("admin")
	fun home(): String {
		return "redirect:/admin/index"
	}

	@RequestMapping("admin/index")
	fun index(model: Model, request: HttpServletRequest): String {
		return "index"
	}

	@RequestMapping("admin/login")
	fun login(model: Model, request: HttpServletRequest): String {
		return "login"
	}

    <#list tables as table>
	@RequestMapping("admin/manager/${table.urlPathName}")
	fun ${table.classNameCamel}(model: Model, request: HttpServletRequest): String {
		return "manager/${table.urlPathName}"
	}
    </#list>
}