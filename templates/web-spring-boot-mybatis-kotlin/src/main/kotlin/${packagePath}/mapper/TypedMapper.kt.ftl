package ${packageName}.mapper

/**
* 通用泛型 mapper 接口
* @author ${author}
* @date ${.now?string("yyyy-MM-dd HH:mm:ss zzzz")}
*/
interface TypedMapper<T> {

    /**
     * 插入一条新数据
     * @param model 添加的数据
     * @return 改变的行数
     */
    fun insert(model: T): Int

    /**
     * 根据ID删除
     * @param id 数据的主键ID
     * @return 改变的行数
     */
    fun delete(id: Any): Int

    /**
     * 更新一条数据
     * @param model 更新的数据
     * @return 改变的行数
     */
    fun update(model: T): Int

    /**
     * 统计全部出数据
     * @return 统计数
     */
    fun countAll(): Int

    /**
     * 根据ID获取
     * @param id 主键ID
     * @return null 或者 主键等于id的数据
     */
    fun findById(id: Any): T?

    /**
     * 获取全部数据
     * @return 全部数据列表
     */
    fun findAll(order: String): List<T>

    /**
     * 分页查询数据
     * @param limit 最大返回
     * @param start 起始返回
     * @return 分页列表数据
     */
    fun findByPage(order: String, limit: Int, start: Int): List<T>

    /**
     * 选择性删除
     * @param where SQL条件语句
     * @return 改变的行数
     */
    fun deleteWhere(where: String): Int

    /**
     * 根据属性值删除
     * @param propertyName 数据库列名
     * @param value 值
     * @return 改变的行数
     */
    fun deleteByPropertyName(propertyName: String, value: Any): Int

    /**
     * 选择性统计
     * @param where SQL条件语句
     * @return 统计数
     */
    fun countWhere(where: String): Int

    /**
     * 根据属性统计
     * @param propertyName 数据库列名
     * @param value 值
     * @return 统计数
     */
    fun countByPropertyName(propertyName: String, value: Any): Int

    /**
     * 选择性查询
     * @param where SQL条件语句
     * @return 符合条件的列表数据
     */
    fun findWhere(order: String, where: String): List<T>

    /**
     * 选择性分页查询
     * @param where SQL条件语句
     * @param limit 最大返回
     * @param start 起始返回
     * @return 符合条件的列表数据
     */
    fun findWhereByPage(order: String, where: String, limit: Int, start: Int): List<T>

    /**
     * 根据属性查询
     * @param propertyName 数据库列名
     * @param value 值
     * @return 返回符合条件的数据列表
     */
    fun findByPropertyName(order: String, propertyName: String, value: Any): List<T>
}