package ${packagename}.controller.base;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import ${packagename}.util.ResultUtil;
import ${packagename}.util.ServiceException;


public class BaseController {
	/**
	 * 执行器
	 * @author Administrator
	 */
	public abstract class Execute {
		public abstract Object execute() throws Exception;
		public String exe(){return exe("");}
		public String exe(String tip){
			try {
				tip = String.format(tip, modelname);
				Object object = this.execute();
				if (object != null) {
					return ResultUtil.getSuccess(object);
				}
			} catch (ServiceException e) {
				return ResultUtil.getFailure(e.getMessage());
			} catch (Throwable e) {
				e.printStackTrace();
				return ResultUtil.getFailure(tip+"失败"+"-"+e.getMessage());
			}
			return ResultUtil.getSuccess(tip+"成功");
		}
	}
	/**
	 * 数据名称
	 */
	protected String modelname = "";
	
	protected void bindModel(Model model, HttpServletRequest request) {
		// TODO Auto-generated method stub
//		String title = "点滴阅读后台管理";
//		model.addAttribute("title", title);
	}

	protected String success(Object message){
		return ResultUtil.getSuccess(message);
	}
	
	protected String failure(Object message){
		return ResultUtil.getFailure(message);
	}
}
