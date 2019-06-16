package ${packageName}.service.impl;

import ${packageName}.dao.${className}Dao;
import ${packageName}.model.${className};
import ${packageName}.model.base.ModelBase;
import ${packageName}.service.${className}Service;
import ${packageName}.service.base.BaseServiceImpl;
import ${packageName}.util.Page;
import ${packageName}.util.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * ${table.remark}的Service接实现
 * @author ${author}
 * @date ${.now?string("yyyy-MM-dd zzzz")}
 */
@Service
public class ${className}ServiceImpl extends BaseServiceImpl<${className}> implements ${className}Service{

	@Autowired
	${className}Dao dao;
	
	@Override
	public int insert(${className} model) throws Exception{
		ModelBase.check(model);
		ModelBase.fillNullID(model);
		return dao.insert(model);
	}
	
	@Override
	public int update(${className} model) throws Exception {
		${className} old = findById(getModelID(model));
		if (old == null) {
			throw new ServiceException("请求更新记录不存在或已经被删除！");
		}
		model = checkNullField(old, model);
		return dao.update(model);
	}

	@Override
	public int delete(Object id) throws Exception {
		return dao.delete(id);
	}

	@Override
	public ${className} findById(Object id) throws Exception{
		return dao.findById(id);
	}

	@Override
	public List<${className}> findAll() throws Exception{
		return dao.findAll();
	}

	@Override
	public int delete(String id) throws Exception{
		return dao.delete(id);
	}

	@Override
	public List<${className}> findByPage(int limit, int start) throws Exception {
		return dao.findByPage(limit,start);
	}

	@Override
	public ${className} findById(String id) throws Exception {
		return dao.findById(id);
	}
	
	@Override
	public Page<${className}> listByPage(int pageSize, int pageNo) throws Exception{
		int limit = pageSize; 
		int start = pageNo*pageSize;
		int totalRecord = dao.countAll();
		int totalPage = 1 + (totalRecord - 1) / pageSize;
		
		List<${className}> list = dao.findByPage(limit, start);
		
		return new Page<${className}>(pageNo,pageSize,totalPage,totalRecord,list){};
	}

	@Override
	public int countAll() throws Exception {
		return dao.countAll();
	}
}
