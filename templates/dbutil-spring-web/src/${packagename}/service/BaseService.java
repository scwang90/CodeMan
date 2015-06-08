package ${packagename}.service;

import ${packagename}.dao.base.BaseDao;
import ${packagename}.util.Page;

/**
 * 通用Service层接口
 * @param <T>
 * @author ${author}
 * @date ${.now?string("yyyy-MM-dd HH:mm:ss zzzz")} 
 */
public interface BaseService<T> extends BaseDao<T>{
	public int delete(String id) throws Exception;
	public T findById(String id) throws Exception;
	public Page<T> listByPage(int pageSize, int pageNo) throws Exception;
}
