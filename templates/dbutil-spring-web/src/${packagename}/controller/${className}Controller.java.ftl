package ${packagename}.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import ${packagename}.annotations.Intent;
import ${packagename}.controller.base.GeneralController;
import ${packagename}.model.${className};

/**
 * ${table.remark} 的Controller层实现
 * @author ${author}
 * @date ${.now?string("yyyy-MM-dd HH:mm:ss zzzz")}     
 */
@Controller
@Intent("${table.remark}")
@RequestMapping("${className}")
public class ${className}Controller extends GeneralController<${className}>{

	/**
	 * 添加信息
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@Override
	@ResponseBody
	@RequestMapping("add")
	public Object add(${className} model) throws Exception {
		// TODO Auto-generated method stub
		return super.add(model);
	}

	/**
	 * 更新信息
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@Override
	@ResponseBody
	@RequestMapping("update")
	public Object update(${className} model) throws Exception {
		// TODO Auto-generated method stub
		return super.update(model);
	}

	/**
	 * 根据ID获取信息
	 * @param ID
	 * @return
	 * @throws Exception 
	 */
	@Override
	@ResponseBody
	@RequestMapping("getByID")
	public Object getByID(String ID) throws Exception {
		// TODO Auto-generated method stub
		return super.getByID(ID);
	}

	/**
	 * 根据ID删除
	 * @return
	 * @throws Exception 
	 */
	@Override
	@ResponseBody
	@RequestMapping("delete")
	public Object delete(String ID) throws Exception {
		// TODO Auto-generated method stub
		return super.delete(ID);
	}

	/**
	 * 统计全部
	 * @return
	 * @throws Exception 
	 */
	@Override
	@ResponseBody
	@RequestMapping("countAll")
	public Object countAll() throws Exception {
		// TODO Auto-generated method stub
		return super.countAll();
	}

	/**
	 * 获取全部列表
	 * @return
	 * @throws Exception 
	 */
	@Override
	@ResponseBody
	@RequestMapping("getAll")
	public Object getAll() throws Exception {
		// TODO Auto-generated method stub
		return super.getAll();
	}

	/**
	 * 获取分页列表
	 * @param pageSize
	 * @param pageNo
	 * @return
	 * @throws Exception 
	 */
	@Override
	@ResponseBody
	@RequestMapping("getListByPage")
	public Object getListByPage(int pageSize, int pageNo) throws Exception {
		// TODO Auto-generated method stub
		return super.getListByPage(pageSize, pageNo);
	}


}
