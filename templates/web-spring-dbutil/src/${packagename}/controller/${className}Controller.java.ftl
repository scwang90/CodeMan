package ${packagename}.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import ${packagename}.annotations.Intent;
import ${packagename}.controller.base.GeneralController;
import ${packagename}.model.${className};
import ${packagename}.service.${className}Service;

/**
 * ${table.remark} 的Controller层实现
 * @author ${author}
 * @date ${.now?string("yyyy-MM-dd HH:mm:ss zzzz")}
 */
@RestController
@Intent("${table.remark}")
@RequestMapping("${className}")
public class ${className}Controller extends GeneralController<${className}>{

	@Autowired
	${className}Service service;
	
	/**
	 * 添加信息
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@Override
	@RequestMapping("Add")
	public Object add(@RequestBody ${className} model) throws Exception {
		// TODO Auto-generated method stub
		service.insert(model);
		return null;
	}

	/**
	 * 更新信息
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@Override
	@RequestMapping("Update")
	public Object update(@RequestBody ${className} model) throws Exception {
		// TODO Auto-generated method stub
		service.update(model);
		return null;
	}

	/**
	 * 根据ID获取信息
	 * @param ID
	 * @return
	 * @throws Exception 
	 */
	@Override
	@RequestMapping("Get/{ID}")
	public Object getByID(@PathVariable String ID) throws Exception {
		// TODO Auto-generated method stub
		Object model = service.findById(ID);
		if (model == null) {
			return "null";
		}
		return model;
	}

	/**
	 * 根据ID删除
	 * @return
	 * @throws Exception 
	 */
	@Override
	@RequestMapping("Delete/{ID}")
	public Object delete(@PathVariable String ID) throws Exception {
		// TODO Auto-generated method stub
		service.delete(ID);
		return null;
	}

	/**
	 * 统计全部
	 * @return
	 * @throws Exception 
	 */
	@Override
	@RequestMapping("CountAll")
	public Object countAll() throws Exception {
		// TODO Auto-generated method stub
		return service.countAll();
	}

	/**
	 * 获取全部列表
	 * @return
	 * @throws Exception 
	 */
	@Override
	@RequestMapping("GetList")
	public Object getList() throws Exception {
		// TODO Auto-generated method stub
		return service.findAll();
	}

	/**
	 * 获取分页列表
	 * @param pageSize
	 * @param pageNo
	 * @return
	 * @throws Exception 
	 */
	@Override
	@RequestMapping("GetList/{pageSize}/{pageNo}")
	public Object getListByPage(@PathVariable int pageSize,@PathVariable int pageNo) throws Exception {
		// TODO Auto-generated method stub
		return service.listByPage(pageSize, pageNo);
	}

}
