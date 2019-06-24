package ${packageName}.dao.base;

import java.util.List;

/**
 * 通用Dao层接口
 * @param <T>
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public interface BaseDao<T> {

	/**
	 * 插入一条新数据
	 * @param model 添加的数据
	 * @return 改变行数
	 */
	int insert(T model);
	/**
	 * 根据ID删除
	 * @param id 主键ID
	 * @return 改变行数
	 */
	int delete(Object id);
	/**
	 * 更新一条数据
	 * @param model 需要更新数据
	 * @return 改变行数
	 */
	int update(T model);
	/**
	 * 统计全部出数据
	 * @return 全部数据量
	 */
	int countAll();
	/**
	 * 根据ID获取
	 * @param id 主键ID
	 * @return 数据对象 or null
	 */
	T findById(Object id);
	/**
	 * 获取全部数据
	 * @return 全部所有数据
	 */
	List<T> findAll();
	/**
	 * 分页查询数据
	 * @param limit 分页最大值
	 * @param start 开始编号
	 * @return 分页列表数据
	 */
	List<T> findByPage(int limit,int start);
	
}
