package ${packagename}.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import ${packagename}.dao.base.BaseDaoImpl;
import ${packagename}.dao.${className}Dao;
import ${packagename}.model.${className};

/**
 * ${table.remark}的Dao实现
 * @author ${author}
 * @date ${.now?string("yyyy-MM-dd HH:mm:ss zzzz")}
 */
@Repository
public class ${className}DaoImpl extends BaseDaoImpl<${className}> implements ${className}Dao{

	@Override
	public int insert(${className} t) throws Exception {
		// TODO Auto-generated method stub
		return super.insert(t);
	}

	@Override
	public int update(${className} t) throws Exception {
		// TODO Auto-generated method stub
		return super.update(t);
	}

	@Override
	public int delete(Object id) throws Exception {
		// TODO Auto-generated method stub
		return super.delete(id);
	}

	@Override
	public int countAll() throws Exception {
		// TODO Auto-generated method stub
		return super.countAll();
	}

	@Override
	public ${className} findById(Object id) throws Exception {
		// TODO Auto-generated method stub
		return super.findById(id);
	}

	@Override
	public List<${className}> findAll() throws Exception {
		// TODO Auto-generated method stub
		return super.findAll();
	}

	@Override
	public List<${className}> findByPage(int limit, int start) throws Exception {
		// TODO Auto-generated method stub
		return super.findByPage(limit, start);
	}
}

