package ${packagename}.service.impl;

import ${packagename}.dao.${className}Dao;
import ${packagename}.model.${className};
import ${packagename}.model.base.ModelBase;
import ${packagename}.service.${className}Service;
import ${packagename}.service.base.BaseServiceImpl;
import ${packagename}.util.Page;
import ${packagename}.util.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * ${table.remark}的Service接实现
 * @author ${author}
 * @date ${.now?string("yyyy-MM-dd HH:mm:ss zzzz")}
 */
@Service
public class ${className}ServiceImpl extends BaseServiceImpl<${className}> implements ${className}Service{

	@Autowired
	${className}Dao dao;
	
	@Override
	public int insert(${className} model){
		ModelBase.check(model);
		ModelBase.fillNullID(model);
		return dao.insert(model);
	}
	
	@Override
	public int update(${className} model) {
		${className} old = findById(getModelID(model));
		if (old == null) {
			throw new ServiceException("请求更新记录不存在或已经被删除！");
		}
		model = checkNullField(old, model);
		return dao.update(model);
	}

	@Override
	public int delete(Object id) {
		return dao.delete(id);
	}

	@Override
	public ${className} findById(Object id){
		return dao.findById(id);
	}

	@Override
	public List<${className}> findAll(){
		return dao.findAll();
	}

	@Override
	public int delete(String id){
		return dao.delete(id);
	}

	@Override
	public List<${className}> findByPage(int limit, int start) {
		return dao.findByPage(limit,start);
	}

	@Override
	public ${className} findById(String id) {
		return dao.findById(id);
	}
	
	@Override
	public Page<${className}> listByPage(int pageSize, int pageNo){
		int limit = pageSize; 
		int start = pageNo*pageSize;
		int totalRecord = dao.countAll();
		int totalPage = 1 + (totalRecord - 1) / pageSize;
		
		List<${className}> list = dao.findByPage(limit, start);
		
		return new Page<${className}>(pageNo,pageSize,totalPage,totalRecord,list){};
	}

	@Override
	public int countAll() {
		return dao.countAll();
	}
}
