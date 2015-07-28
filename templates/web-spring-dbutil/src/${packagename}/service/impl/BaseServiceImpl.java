package ${packagename}.service.impl;

import java.lang.reflect.Field;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;

import ${packagename}.annotations.dbmodel.interpreter.Interpreter;
import ${packagename}.dao.base.BaseDao;
import ${packagename}.service.BaseService;
import ${packagename}.util.AfReflecter;
import ${packagename}.util.JacksonUtil;
import ${packagename}.util.Page;
import ${packagename}.util.ServiceException;

/**
 * 通用Service层实现基类
 * @param <T>
 * @author ${author}
 * @date ${.now?string("yyyy-MM-dd HH:mm:ss zzzz")}
 */
public class BaseServiceImpl<T> implements BaseService<T>{

	@Autowired
	BaseDao<T> baseDao;
	
	protected Class<T> clazz;
	
	public BaseServiceImpl() {
		// TODO Auto-generated constructor stub
		this.clazz = AfReflecter.getActualTypeArgument(this, BaseServiceImpl.class, 0);
	}
	
	@Override
	public int insert(T model) throws Exception{
		// TODO Auto-generated method stub
		checkNullID(model);
		return baseDao.insert(model);
	}
	
	@Override
	public int update(T model) throws Exception {
		// TODO Auto-generated method stub
		T old = findById(getModelID(model));
		if (old == null) {
			throw new ServiceException("请求更新记录不存在或已经被删除！");
		}
		model = checkNullField(old, model);
		return baseDao.update(model);
	}

	@Override
	public int delete(Object id) throws Exception {
		// TODO Auto-generated method stub
		return baseDao.delete(id);
	}

	@Override
	public T findById(Object id) throws Exception{
		// TODO Auto-generated method stub
		return baseDao.findById(id);
	}

	@Override
	public List<T> findAll() throws Exception{
		// TODO Auto-generated method stub
		return baseDao.findAll();
	}

	@Override
	public int delete(String id) throws Exception{
		// TODO Auto-generated method stub
		return baseDao.delete(id);
	}

	@Override
	public List<T> findByPage(int limit, int start) throws Exception {
		// TODO Auto-generated method stub
		return baseDao.findByPage(limit,start);
	}

	@Override
	public T findById(String id) throws Exception {
		// TODO Auto-generated method stub
		return baseDao.findById(id);
	}
	
	@Override
	public Page<T> listByPage(int pageSize, int pageNo) throws Exception{
		// TODO Auto-generated method stub
		int limit = pageSize; 
		int start = pageNo*pageSize;
		int totalRecord = baseDao.countAll();
		int totalPage = 1+totalRecord/pageSize;
		
		List<T> list = baseDao.findByPage(limit, start);
		
		return new Page<T>(pageNo,pageSize,totalPage,totalRecord,list){};
	}

	@Override
	public int countAll() throws Exception {
		// TODO Auto-generated method stub
		return baseDao.countAll();
	}
	/**
	 * 检查ID字段是否为空，否则设置一个新ID
	 * @param model
	 * @throws Exception
	 */
	protected void checkNullID(T model) throws Exception {
		Class<?> clazz = model.getClass();
		Field field = Interpreter.getIdField(clazz);
		field.setAccessible(true);
		Object id = field.get(model);
		if(id == null || id.toString().trim().length() == 0){
			field.set(model, UUID.randomUUID().toString());
		}
	}
	/**
	 * 检测非空字段
	 * @param old
	 * @param model
	 */
	@SuppressWarnings("unchecked")
	protected T checkNullField(T old, T model) {
		// TODO Auto-generated method stub
		try {
			Class<?> clazz = model.getClass();
			old = (T) JacksonUtil.toObject(JacksonUtil.toJson(old), clazz);
			for (Field field : clazz.getDeclaredFields()) {
				field.setAccessible(true);
				Object nfield = field.get(model);
				if (nfield != null) {
					field.set(old, nfield);
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			
		}
		return old;
	}
	/**
	 * 获取ID字段
	 * @param model
	 * @throws Exception 
	 * @throws IllegalArgumentException 
	 * @throws Exception
	 */
	protected Object getModelID(T model) throws Exception {
		Class<?> clazz = model.getClass();
		Field field = Interpreter.getIdField(clazz);
		field.setAccessible(true);
		return field.get(model);
	}
}
