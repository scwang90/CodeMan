package ${packagename}.controller.base;

import org.springframework.beans.factory.annotation.Autowired;

import ${packagename}.service.BaseService;
import ${packagename}.util.Page;

/**
 * @author Administrator
 * @param <T>
 */
public class GeneralController<T> extends BaseController{
	

	@Autowired
	BaseService<T> service;

	/**
	 * 添加信息
	 * @param model
	 * @return
	 */
	public String add(final T model) {
		return new Execute() {public Object execute() throws Exception {
			service.insert(model);
			return null;
		}}.exe("添加%s");
	}
	/**
	 * 更新信息
	 * @param model
	 * @return
	 */
	public String update(final T model) {
		return new Execute() {public Object execute() throws Exception {
				service.update(model);
				return null;
		}}.exe("更新%s");
	}
	/**
	 * 根据ID获取信息
	 * @param ID
	 * @return
	 */
	public String getByID(final String ID) {
		return new Execute() {public Object execute() throws Exception {
				return service.findById(ID);
		}}.exe("获取%s");
	}
	/**
	 * 根据ID删除
	 * @return
	 */
	public String delete(final String ID) {
		return new Execute() {public Object execute() throws Exception {
				service.delete(ID);
				return null;
		}}.exe("删除%s");
	}

	/**
	 * 获取全部列表
	 * @return
	 */
	public String countAll() {
		return new Execute() {public Object execute() throws Exception {
				return service.countAll();
		}}.exe("统计%s");
	}

	/**
	 * 获取全部列表
	 * @return
	 */
	public String getAll() {
		return new Execute() {public Object execute() throws Exception {
				return new Page<T>(service.findAll()){};
		}}.exe("获取全部%s列表");
	}

	/**
	 * 获取分页列表
	 * @param pageSize
	 * @param pageNo
	 * @return
	 */
	public String getListByPage(final int pageSize, final int pageNo) {
		return new Execute() {public Object execute() throws Exception {
				return service.listByPage(pageSize, pageNo);
		}}.exe("获取%s列表");
	}

}
