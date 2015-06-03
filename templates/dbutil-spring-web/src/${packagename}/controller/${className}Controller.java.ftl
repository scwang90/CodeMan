package ${packagename}.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import ${packagename}.controller.base.GeneralController;
import ${packagename}.model.${className};

/**
 * ${table.remark}Controller
 * @author ${author}
 */
@Controller
@RequestMapping("${className}")
public class ${className}Controller extends GeneralController<${className}>{

	@Override
	@ResponseBody
	@RequestMapping("add")
	public String add(${className} model) {
		// TODO Auto-generated method stub
		return super.add(model);
	}

	@Override
	@ResponseBody
	@RequestMapping("update")
	public String update(${className} model) {
		// TODO Auto-generated method stub
		return super.update(model);
	}

	@Override
	@ResponseBody
	@RequestMapping("getByID")
	public String getByID(String ID) {
		// TODO Auto-generated method stub
		return super.getByID(ID);
	}

	@Override
	@ResponseBody
	@RequestMapping("delete")
	public String delete(String ID) {
		// TODO Auto-generated method stub
		return super.delete(ID);
	}

	@Override
	@ResponseBody
	@RequestMapping("countAll")
	public String countAll() {
		// TODO Auto-generated method stub
		return super.countAll();
	}

	@Override
	@RequestMapping("getAll")
	public String getAll() {
		// TODO Auto-generated method stub
		return super.getAll();
	}

	@Override
	@ResponseBody
	@RequestMapping("getListByPage")
	public String getListByPage(int pageSize, int pageNo) {
		// TODO Auto-generated method stub
		return super.getListByPage(pageSize, pageNo);
	}


}
