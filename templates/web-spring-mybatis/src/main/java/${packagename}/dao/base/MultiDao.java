package ${packagename}.dao.base;

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
	 * @param where
	 * @return
	 * @throws Exception
	 */
	public int deleteWhere(String where);
	/**
	 * 根据属性值删除
	 * @param propertyName
	 * @param value
	 * @return
	 * @throws Exception
	 */
	public int deleteByPropertyName(String propertyName,Object value);
	/**
	 * 选择性统计
	 * @param where
	 * @return
	 * @throws Exception
	 */
	public int countWhere(String where);
	/**
	 * 根据属性统计
	 * @param propertyName
	 * @param value
	 * @return
	 * @throws Exception
	 */
	public int countByPropertyName(String propertyName,Object value);
	/**
	 * 选择性查询
	 * @param where
	 * @return
	 * @throws Exception
	 */
	public List<T> findWhere( String where);
	/**
	 * 选择性分页查询
	 * @param where
	 * @param limit
	 * @param start
	 * @return
	 * @throws Exception
	 */
	public List<T> findWhereByPage(String where, int limit,int start);
	/**
	 * 根据属性查询
	 * @param propertyName
	 * @param value
	 * @return
	 * @throws Exception
	 */
	public List<T> findByPropertyName(String propertyName,Object value);

}
