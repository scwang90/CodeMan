package ${packageName}.controller;

import ${packageName}.controller.base.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
public class IndexController extends BaseController {
    <#list tables as table>

	@RequestMapping(value="${table.classNameLower}/view")
	public String ${table.classNameCamel}(Model model, HttpServletRequest request) {
		super.bindModel(model, request);
		return "${table.classNameLower}";
	}
    </#list>
}