package ${packagename}.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import ${packagename}.model.${className};
import ${packagename}.service.${className}Service;
import ${packagename}.util.Page;

/**
 * ${table.remark}的Service接实现
 * @author ${author}
 * @date ${.now?string("yyyy-MM-dd HH:mm:ss zzzz")}     
 */
@Service
public class ${className}ServiceImpl extends BaseServiceImpl<${className}> implements ${className}Service{

	@Override
	public int insert(${className} model) throws Exception {
		// TODO Auto-generated method stub
		return super.insert(model);
	}

	@Override
	public int update(${className} model) throws Exception {
		// TODO Auto-generated method stub
		return super.update(model);
	}

	@Override
	public int delete(Object model) throws Exception {
		// TODO Auto-generated method stub
		return super.delete(model);
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
	public int delete(String id) throws Exception {
		// TODO Auto-generated method stub
		return super.delete(id);
	}

	@Override
	public List<${className}> findByPage(int limit, int start) throws Exception {
		// TODO Auto-generated method stub
		return super.findByPage(limit, start);
	}

	@Override
	public ${className} findById(String id) throws Exception {
		// TODO Auto-generated method stub
		return super.findById(id);
	}

	@Override
	public Page<${className}> listByPage(int pageSize, int pageNo) throws Exception {
		// TODO Auto-generated method stub
		return super.listByPage(pageSize, pageNo);
	}

	@Override
	public int countAll() throws Exception {
		// TODO Auto-generated method stub
		return super.countAll();
	}
	
}
