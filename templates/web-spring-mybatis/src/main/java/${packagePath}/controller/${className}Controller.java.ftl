package ${packageName}.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import ${packageName}.annotations.Intent;
import ${packageName}.controller.base.GeneralController;
import ${packageName}.model.${className};
import ${packageName}.service.${className}Service;

/**
 * ${table.remark} 的Controller层实现
 * @author ${author}
 * @since ${.now?string("yyyy-MM-dd zzzz")}
 */
@RestController
@Intent("${table.remark}")
@RequestMapping("${table.classNameLower}")
public class ${className}Controller extends GeneralController<${className}>{

	@Autowired
	${className}Service service;
	
	/**
	 * 添加信息
	 * @param model 添加的数据
	 * @return 改变行数
	 */
	@Override
	@RequestMapping("add")
	public Object add(@RequestBody ${className} model) {
		return service.insert(model);
	}

	/**
	 * 更新信息
	 * @param model 更新的数据
	 * @return 改变行数
	 */
	@Override
	@RequestMapping("update")
	public Object update(@RequestBody ${className} model) {
		return service.update(model);
	}

	/**
	 * 根据ID获取信息
	 * @param ID 主键ID
	 * @return 数据
	 */
	@Override
	@RequestMapping("get/{ID}")
	public Object get(@PathVariable String ID) {
		Object model = service.findById(ID);
		if (model == null) {
			return "null";
		}
		return model;
	}

	/**
	 * 根据ID删除
	 * @return 改变行数
	 */
	@Override
	@RequestMapping("delete/{ID}")
	public Object delete(@PathVariable String ID) {
		return service.delete(ID);
	}

	/**
	 * 统计全部
	 * @return 统计数
	 */
	@Override
	@RequestMapping("count")
	public Object count() {
		return service.countAll();
	}

	/**
	 * 获取全部列表
	 * @return 数据列表
	 */
	@Override
	@RequestMapping("list")
	public Object list() {
		return service.findAll();
	}

	/**
	 * 获取分页列表
	 * @param pageSize 分页大小
	 * @param pageNo 分页页数
	 * @return 数据列表
	 */
	@Override
	@RequestMapping("list/{pageSize}/{pageNo}")
	public Object listByPage(@PathVariable int pageSize,@PathVariable int pageNo) {
		return service.listByPage(pageSize, pageNo);
	}

}
