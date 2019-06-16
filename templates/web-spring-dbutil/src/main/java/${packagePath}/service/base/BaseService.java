package ${packageName}.service.base;

import ${packageName}.dao.base.BaseDao;
import ${packageName}.util.Page;

/**
 * 通用Service层接口
 * @param <T>
 * @author ${author}
 * @date ${.now?string("yyyy-MM-dd zzzz")}
 */
public interface BaseService<T> extends BaseDao<T>{
	int delete(String id) throws Exception;
	T findById(String id) throws Exception;
	Page<T> listByPage(int pageSize, int pageNo) throws Exception;
}
