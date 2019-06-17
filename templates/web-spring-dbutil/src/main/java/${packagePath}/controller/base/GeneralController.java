package ${packageName}.controller.base;

import org.springframework.beans.factory.annotation.Autowired;

import ${packageName}.annotations.Intent;
import ${packageName}.service.base.BaseService;

/**
 * Controller 层通用处理事务基类
 * @param <T>
 * @author ${author}
 * @since ${.now?string("yyyy-MM-dd zzzz")}
 */
public class GeneralController<T> extends BaseController{
	
	@Autowired
	BaseService<T> service;

	/**
	 * 添加信息
	 */
	@Intent("添加%s")
	public Object add(T model) throws Exception {
		service.insert(model);
		return null;
	}
	/**
	 * 更新信息
	 */
	@Intent("更新%s")
	public Object update(T model) throws Exception {
		service.update(model);
		return null;
	}
	/**
	 * 根据ID获取信息
	 */
	@Intent("获取%s")
	public Object get(String ID) throws Exception {
		Object model = service.findById(ID);
		if (model == null) {
			return "null";
		}
		return model;
	}
	/**
	 * 根据ID删除
	 */
	@Intent("删除%s")
	public Object delete(final String ID) throws Exception {
		service.delete(ID);
		return null;
	}

	/**
	 * 获取全部列表
	 */
	@Intent("统计%s")
	public Object count() throws Exception {
		return service.countAll();
	}

	/**
	 * 获取全部列表
	 */
	@Intent("获取全部%s列表")
	public Object list() throws Exception {
		return service.findAll();
	}

	/**
	 * 获取分页列表
	 */
	@Intent("获取%s列表")
	public Object listByPage(int pageSize,int pageNo) throws Exception {
		return service.listByPage(pageSize, pageNo);
	}
	
}
