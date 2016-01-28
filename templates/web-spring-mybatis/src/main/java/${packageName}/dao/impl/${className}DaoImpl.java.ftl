package ${packageName}.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import ${packageName}.dao.base.BaseDaoImpl;
import ${packageName}.dao.${className}Dao;
import ${packageName}.model.${className};

/**
 * ${table.remark}的Dao实现
 * @author ${author}
 * @date ${.now?string("yyyy-MM-dd HH:mm:ss zzzz")}
 */
@Repository
public class ${className}DaoImpl extends BaseDaoImpl<${className}> implements ${className}Dao{

	@Override
	public int insert(${className} t) {
		return super.insert(t);
	}

	@Override
	public int update(${className} t) {
		return super.update(t);
	}

	@Override
	public int delete(Object id) {
		return super.delete(id);
	}

	@Override
	public int countAll() {
		return super.countAll();
	}

	@Override
	public ${className} findById(Object id) {
		return super.findById(id);
	}

	@Override
	public List<${className}> findAll() {
		return super.findAll();
	}

	@Override
	public List<${className}> findByPage(int limit, int start) {
		return super.findByPage(limit, start);
	}
}

