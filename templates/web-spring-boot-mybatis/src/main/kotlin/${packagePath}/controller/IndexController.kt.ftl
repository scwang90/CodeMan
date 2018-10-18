package ${packageName}.controller

import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.RequestMapping
import javax.servlet.http.HttpServletRequest

/**
* url 映射
* @author ${author}
* @date ${.now?string("yyyy-MM-dd HH:mm:ss zzzz")}
*/
@Controller
class IndexController {
    <#list tables as table>
	@RequestMapping(value=["${table.classNameLower}/view"])
	fun ${table.classNameCamel}(model: Model, request: HttpServletRequest): String {
		return "${table.classNameLower}"
	}
    </#list>
}