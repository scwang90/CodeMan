package ${packageName}.service.base;

import ${packageName}.dao.base.BaseDao;
import ${packageName}.util.Page;

/**
 * 通用Service层接口
 * @param <T>
 * @author ${author}
 * @since ${.now?string("yyyy-MM-dd zzzz")}
 */
public interface BaseService<T> extends BaseDao<T>{
	int delete(String id);
	T findById(String id);
	Page<T> listByPage(int pageSize, int pageNo);
}
