package ${packageName}.dao.base;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import ${packageName}.util.AfReflecter;

/**
 * Mybatis - MYSQL 对 MultiDao 接口的实现
 * @param <T>
 * @author 树朾
 * @since 2015-06-29 18:20:50 中国标准时间
 */
public class BaseDaoMybatisMYSQLImpl<T> implements MultiDao<T> {
	
	public interface MybatisMultiDao<T>{
		int insert(T model);
		int delete(Object id);
		int update(T model);
		int countAll();
		T findById(Object id);
		List<T> findAll(String order);
		List<T> findByPage(String order,int limit,int start);
		int deleteWhere(String where) ;
		int deleteByPropertyName(String propertyName,Object value);
		int countWhere(String where);
		int countByPropertyName(String propertyName, Object value) ;
		List<T> findWhere(String order, String where) ;
		List<T> findWhereByPage(String order, String where, int limit,int start);
		List<T> findByPropertyName(String order, String propertyName,Object value);
	}

	protected Class<T> clazz;

	protected String order = "";
	
	@Autowired
	protected MybatisMultiDao<T> multiDao;
	
	public BaseDaoMybatisMYSQLImpl() {
		clazz = AfReflecter.getActualTypeArgument(this,
				BaseDaoMybatisMYSQLImpl.class, 0);
	}

	@Override
	public int insert(T model) {
		return multiDao.insert(model);
	}

	@Override
	public int delete(Object id) {
		return multiDao.delete(id);
	}

	@Override
	public int update(T model) {
		return multiDao.update(model);
	}

	@Override
	public int countAll() {
		return multiDao.countAll();
	}

	@Override
	public T findById(Object id) {
		return multiDao.findById(id);
	}

	@Override
	public List<T> findAll() {
		return multiDao.findAll(order);
	}

	@Override
	public List<T> findByPage(int limit, int start) {
		return multiDao.findByPage(order, limit, start);
	}

	@Override
	public int deleteWhere(String where) {
		return multiDao.deleteWhere(where);
	}

	@Override
	public int deleteByPropertyName(String propertyName, Object value) {
		return multiDao.deleteByPropertyName(propertyName, value);
	}

	@Override
	public int countWhere(String where) {
		return multiDao.countWhere(where);
	}

	@Override
	public int countByPropertyName(String propertyName, Object value) {
		return multiDao.countByPropertyName(propertyName, value);
	}

	@Override
	public List<T> findWhere(String where) {
		if (where.toLowerCase().indexOf("order by ") < 0) {
			return multiDao.findWhere(order, where);
		}else {
			return multiDao.findWhere("", where);
		}
	}

	@Override
	public List<T> findWhereByPage(String where, int limit, int start) {
		if (where.toLowerCase().indexOf("order by ") < 0) {
			return multiDao.findWhereByPage(order, where, limit, start);
		}else {
			return multiDao.findWhereByPage("", where, limit, start);
		}
	}

	@Override
	public List<T> findByPropertyName(String propertyName, Object value) {
		if (value instanceof java.util.Date) {
			java.util.Date date = (java.util.Date) value;
			value = new java.sql.Date(date.getTime());
		}
		return multiDao.findByPropertyName(order, propertyName, value);
	}

}
