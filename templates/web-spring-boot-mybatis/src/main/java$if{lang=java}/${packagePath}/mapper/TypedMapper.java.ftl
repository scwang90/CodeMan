package ${packageName}.mapper;

import java.util.List;

/**
* 通用泛型 mapper 接口
* @author ${author}
* @since ${now?string("yyyy-MM-dd zzzz")}
*/
public interface TypedMapper<T> {

    /**
     * 插入一条新数据
     * @param model 添加的数据
     * @return 改变的行数
     */
    int insert(T model);

    /**
     * 根据ID删除
     * @param id 数据的主键ID
     * @return 改变的行数
     */
    int delete(Object id);

    /**
     * 更新一条数据
     * @param model 更新的数据
     * @return 改变的行数
     */
    int update(T model);

    /**
     * 统计全部出数据
     * @return 统计数
     */
    int countAll();

    /**
     * 根据ID获取
     * @param id 主键ID
     * @return null 或者 主键等于id的数据
     */
    T findById(Object id);

    /**
     * 获取一条数据
     * @param order SQL排序语句
     * @param where SQL条件语句
     * @return null 或者 匹配条件的数据
     */
    T findOne(String order, String where);

    /**
     * 根据属性查询
     * @param order SQL排序语句
     * @param property 数据库列名
     * @param value 值
     * @return 返回符合条件的数据列表
     */
    T findOneByPropertyName(String order, String property, Object value);

    /**
     * 获取全部数据
     * @param order SQL排序语句
     * @return 全部数据列表
     */
    List<T> findAll(String order);

    /**
     * 分页查询数据
     * @param order SQL排序语句
     * @param limit 最大返回
     * @param start 起始返回
     * @return 分页列表数据
     */
    List<T> findByPage(String order, int limit, int start);

    /**
     * 选择性删除
     * @param where SQL条件语句
     * @return 改变的行数
     */
    int deleteWhere(String where);

    /**
     * 根据属性值删除
     * @param property 数据库列名
     * @param value 值
     * @return 改变的行数
     */
    int deleteByPropertyName(String property, Object value);

    /**
     * 选择性统计
     * @param where SQL条件语句
     * @return 统计数
     */
    int countWhere(String where);

    /**
     * 根据属性统计
     * @param property 数据库列名
     * @param value 值
     * @return 统计数
     */
    int countByPropertyName(String property, Object value);

    /**
     * 选择性查询
     * @param order SQL排序语句
     * @param where SQL条件语句
     * @return 符合条件的列表数据
     */
    List<T> findWhere(String order, String where);

    /**
     * 选择性分页查询
     * @param order SQL排序语句
     * @param where SQL条件语句
     * @param limit 最大返回
     * @param start 起始返回
     * @return 符合条件的列表数据
     */
    List<T> findWhereByPage(String order, String where, int limit, int start);

    /**
     * 根据属性查询
     * @param order SQL排序语句
     * @param property 数据库列名
     * @param value 值
     * @return 返回符合条件的数据列表
     */
    List<T> findByPropertyName(String order, String property, Object value);
}
