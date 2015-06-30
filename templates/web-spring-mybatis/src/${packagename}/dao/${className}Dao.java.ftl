package ${packagename}.dao;

import java.util.List;

import ${packagename}.dao.base.BaseDao;
import ${packagename}.model.${className};

/**
 * ${table.remark}的Dao接口
 * @author ${author}
 * @date ${.now?string("yyyy-MM-dd HH:mm:ss zzzz")}
 */
public interface ${className}Dao extends BaseDao<${className}>{

	/**
	 * 插入一条新数据
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public int insert(${className} model) throws Exception;
	/**
	 * 根据ID删除
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public int delete(Object id) throws Exception;
	/**
	 * 更新一条数据
	 * @param model
	 * @return
	 * @throws Exception
	 */
	public int update(${className} model) throws Exception;
	/**
	 * 统计全部出数据
	 * @return
	 * @throws Exception
	 */
	public int countAll() throws Exception;
	/**
	 * 根据ID获取
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public ${className} findById(Object id) throws Exception;
	/**
	 * 获取全部数据
	 * @return
	 * @throws Exception
	 */
	public List<${className}> findAll() throws Exception;
	/**
	 * 分页查询数据
	 * @param limit
	 * @param start
	 * @return
	 * @throws Exception
	 */
	public List<${className}> findByPage(int limit,int start) throws Exception;
	

}
