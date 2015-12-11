package ${packagename}.service.base;

import ${packagename}.dao.base.BaseDao;
import ${packagename}.util.Page;

/**
 * 通用Service层接口
 * @param <T>
 * @author ${author}
 * @date ${.now?string("yyyy-MM-dd HH:mm:ss zzzz")}
 */
public interface BaseService<T> extends BaseDao<T>{
	int delete(String id);
	T findById(String id);
	Page<T> listByPage(int pageSize, int pageNo);
}
