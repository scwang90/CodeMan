package ${packagename}.dao.base;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import ${packagename}.util.AfReflecter;

/**
 * Mybatis - MYSQL 对 MultiDao 接口的实现
 * @param <T>
 * @author 树朾
 * @date 2015-06-29 18:20:50 中国标准时间 
 */
public class BaseDaoMybatisMYSQLImpl<T> implements MultiDao<T> {
	
	public interface MybatisMultiDao<T>{
		public int insert(T model) throws Exception;
		public int delete(Object id) throws Exception;
		public int update(T model) throws Exception;
		public int countAll() throws Exception;
		public T findById(Object id) throws Exception;
		public List<T> findAll(String order) throws Exception;
		public List<T> findByPage(String order,int limit,int start) throws Exception;
		public int deleteWhere(String where) throws Exception ;
		public int deleteByPropertyName(String propertyName,Object value) throws Exception;
		public int countWhere(String where) throws Exception;
		public int countByPropertyName(String propertyName, Object value) throws Exception ;
		public List<T> findWhere(String order, String where) throws Exception ;
		public List<T> findWhereByPage(String order, String where, int limit,int start) throws Exception;
		public List<T> findByPropertyName(String order, String propertyName,Object value) throws Exception;
	}

	protected Class<T> clazz;

	protected String order = "";
	
	@Autowired
	protected MybatisMultiDao<T> multiDao;
	
	public BaseDaoMybatisMYSQLImpl() {
		// TODO Auto-generated constructor stub
		clazz = AfReflecter.getActualTypeArgument(this,
				BaseDaoMybatisMYSQLImpl.class, 0);
	}

	@Override
	public int insert(T model) throws Exception {
		return multiDao.insert(model);
	}

	@Override
	public int delete(Object id) throws Exception {
		return multiDao.delete(id);
	}

	@Override
	public int update(T model) throws Exception {
		return multiDao.update(model);
	}

	@Override
	public int countAll() throws Exception {
		return multiDao.countAll();
	}

	@Override
	public T findById(Object id) throws Exception {
		return multiDao.findById(id);
	}

	@Override
	public List<T> findAll() throws Exception {
		return multiDao.findAll(order);
	}

	@Override
	public List<T> findByPage(int limit, int start) throws Exception {
		return multiDao.findByPage(order, limit, start);
	}

	@Override
	public int deleteWhere(String where) throws Exception {
		return multiDao.deleteWhere(where);
	}

	@Override
	public int deleteByPropertyName(String propertyName, Object value)
			throws Exception {
		return multiDao.deleteByPropertyName(propertyName, value);
	}

	@Override
	public int countWhere(String where) throws Exception {
		return multiDao.countWhere(where);
	}

	@Override
	public int countByPropertyName(String propertyName, Object value)
			throws Exception {
		return multiDao.countByPropertyName(propertyName, value);
	}

	@Override
	public List<T> findWhere(String where) throws Exception {
		if (where.toLowerCase().indexOf("order by ") < 0) {
			return multiDao.findWhere(order, where);
		}else {
			return multiDao.findWhere("", where);
		}
	}

	@Override
	public List<T> findWhereByPage(String where, int limit, int start)
			throws Exception {
		if (where.toLowerCase().indexOf("order by ") < 0) {
			return multiDao.findWhereByPage(order, where, limit, start);
		}else {
			return multiDao.findWhereByPage("", where, limit, start);
		}
	}

	@Override
	public List<T> findByPropertyName(String propertyName, Object value)
			throws Exception {
		if (value instanceof java.util.Date) {
			java.util.Date date = (java.util.Date) value;
			value = new java.sql.Date(date.getTime());
		}
		return multiDao.findByPropertyName(order, propertyName, value);
	}

}
