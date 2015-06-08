package ${packagename}.controller.base;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

/**
 * Controller 层基类
 * @author ${author}
 * @date ${.now?string("yyyy-MM-dd HH:mm:ss zzzz")} 
 */
public class BaseController {
	
	protected void bindModel(Model model, HttpServletRequest request) {
		// TODO Auto-generated method stub
//		String title = "XXX后台管理系统";
//		model.addAttribute("title", title);
	}

//	protected String success(Object message){
//		return ResultUtil.getSuccess(message);
//	}
//	
//	protected String failure(Object message){
//		return ResultUtil.getFailure(message);
//	}
}
