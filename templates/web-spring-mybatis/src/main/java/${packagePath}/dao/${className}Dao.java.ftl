package ${packageName}.dao;

import java.util.List;

import ${packageName}.dao.base.BaseDao;
import ${packageName}.model.${className};

/**
 * ${table.remark}的Dao接口
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public interface ${className}Dao extends BaseDao<${className}>{

	/**
	 * 插入一条新数据
	 * @param model 添加的数据
	 * @return 改变行数
	 */
	int insert(${className} model);
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
	int update(${className} model);
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
	${className} findById(Object id);
	/**
	 * 获取全部数据
	 * @return 全部所有数据
	 */
	List<${className}> findAll();
	/**
	 * 分页查询数据
	 * @param limit 分页最大值
	 * @param start 开始编号
	 * @return 分页列表数据
	 */
	List<${className}> findByPage(int limit,int start);
	

}
