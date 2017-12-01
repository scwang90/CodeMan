package ${packageName}.dao.base;

import java.util.List;

/**
 * 多功能Dao层接口
 * @param <T>
 * @author ${author}
 * @date ${.now?string("yyyy-MM-dd HH:mm:ss zzzz")}
 */
public interface MultiDao<T> extends BaseDao<T>{
	/**
	 * 选择性删除
	 */
	public int deleteWhere(String where) throws Exception;
	/**
	 * 根据属性值删除
	 */
	public int deleteByPropertyName(String propertyName,Object value) throws Exception;
	/**
	 * 选择性统计
	 */
	public int countWhere(String where) throws Exception;
	/**
	 * 根据属性统计
	 */
	public int countByPropertyName(String propertyName,Object value) throws Exception;
	/**
	 * 选择性查询
	 */
	public List<T> findWhere( String where) throws Exception;
	/**
	 * 选择性分页查询
	 */
	public List<T> findWhereByPage(String where, int limit,int start) throws Exception;
	/**
	 * 根据属性查询
	 */
	public List<T> findByPropertyName(String propertyName,Object value) throws Exception;

}
