package ${packageName}.mapper;

import ${packageName}.util.SqlIntent;

import org.apache.ibatis.session.RowBounds;

import java.util.List;

/**
* 通用泛型 mapper 接口
* @author ${author}
* @since ${now?string("yyyy-MM-dd zzzz")}
*/
public interface TypedMapper<T> {


	/**
	 * 插入新数据（非空插入，不支持批量插入）
	 * @param model 添加的数据
	 * @return 改变的行数
	 */
	int insert(T model);

	/**
	 * 插入新数据（全插入，支持批量插入）
	 * @param models 添加的数据集合
	 * @return 改变的行数
	 */
	int insertFull(T... models);

	/**
	 * 更新一条数据（非空更新）
	 * @param model 更新的数据
	 * @return 改变的行数
	 */
	int update(T model);

	/**
	 * 更新一条数据（全更新）
	 * @param model 更新的数据
	 * @return 改变的行数
	 */
	int updateFull(T model);

	/**
	 * 更新一条数据（灵活构建意图）
	 * @param id 主键Id
	 * @param intent 意图
	 * @return 改变的行数
	 */
	int updateIntent(Object id, SqlIntent intent);

	/**
	 * 根据ID删除（支持批量删除）
	 * @param ids 数据的主键ID
	 * @return 改变的行数
	 */
	int delete(Object... ids);

	/**
	 * 根据条件删除（Where 拼接）
	 * @param where SQL条件语句
	 * @return 改变的行数
	 */
	int deleteWhere(String where);

	/**
	 * 根据条件删除（灵活构建意图）
	 * @param intent 意图
	 * @return 改变的行数
	 */
	int deleteIntent(SqlIntent intent);

	/**
	 * 统计数量（全部）
	 * @return 统计数
	 */
	int countAll();

	/**
	 * 统计数量（Where 拼接）
	 * @param where SQL条件语句
	 * @return 改变的行数
	 */
	int countWhere(String where);

	/**
	 * 统计数量（灵活构建意图）
	 * @param intent 意图
	 * @return 改变的行数
	 */
	int countIntent(SqlIntent intent);

	/**
	 * 根据ID获取
	 * @param id 主键ID
	 * @return null 或者 主键等于id的数据
	 */
	T findById(Object id);

	/**
	 * 单条查询（Where 拼接 Order 拼接）
	 * @param where SQL条件语句
	 * @param order SQL排序语句
	 * @return null 或者 匹配条件的数据
	 */
	T findOneWhere(String where, String order);

	/**
	 * 单条查询（灵活构建意图）
	 * @param intent 意图
	 */
	T findOneIntent(SqlIntent intent);

	/**
	 * 批量查询（Where 拼接 Order 拼接）
	 * @param where SQL条件语句
	 * @param order SQL排序语句
	 * @return null 或者 匹配条件的数据
	 */
	List<T> findWhere(String where, String order);

	/**
	 * 批量查询（灵活构建意图）
	 * @param intent 意图
	 */
	List<T> findIntent(SqlIntent intent);

	/**
	 * 批量查询（Where 拼接 Order 拼接，分页）
	 * @param where SQL条件语句
	 * @param order SQL排序语句
	 * @return null 或者 匹配条件的数据
	 */
	List<T> findWhere(String where, String order, RowBounds rows);

	/**
	 * 批量查询（灵活构建意图，分页）
	 * @param intent 意图
	 */
	List<T> findIntent(SqlIntent intent, RowBounds rows);

}
