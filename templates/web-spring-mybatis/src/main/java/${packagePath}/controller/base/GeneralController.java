package ${packageName}.controller.base;

import org.springframework.beans.factory.annotation.Autowired;

import ${packageName}.annotations.Intent;
import ${packageName}.service.base.BaseService;

/**
 * Controller 层通用处理事务基类
 * @param <T>
 * @author ${author}
 * @date ${.now?string("yyyy-MM-dd HH:mm:ss zzzz")}
 */
public class GeneralController<T> extends BaseController{
	
	@Autowired
	BaseService<T> service;

	/**
	 * 添加信息
	 * @param model 添加的数据
	 * @return 改变行数
	 */
	@Intent("添加%s")
	public Object add(T model) {
		service.insert(model);
		return null;
	}
	/**
	 * 更新信息
	 * @param model 更新的数据
	 * @return 改变行数
	 */
	@Intent("更新%s")
	public Object update(T model) {
		service.update(model);
		return null;
	}
	/**
	 * 根据ID获取信息
	 * @param ID 主键ID
	 * @return 数据
	 */
	@Intent("获取%s")
	public Object get(String ID) {
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
	@Intent("删除%s")
	public Object delete(final String ID) {
		service.delete(ID);
		return null;
	}

	/**
	 * 统计全部
	 * @return 统计数
	 */
	@Intent("统计%s")
	public Object count() {
		return service.countAll();
	}

	/**
	 * 获取全部列表
	 * @return 数据列表
	 */
	@Intent("获取全部%s列表")
	public Object list() {
		return service.findAll();
	}

	/**
	 * 获取分页列表
	 * @param pageSize 分页大小
	 * @param pageNo 分页页数
	 * @return 数据列表
	 */
	@Intent("获取%s列表")
	public Object listByPage(int pageSize,int pageNo) {
		return service.listByPage(pageSize, pageNo);
	}
	
}
