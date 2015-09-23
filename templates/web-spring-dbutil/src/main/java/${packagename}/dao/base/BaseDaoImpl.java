package ${packagename}.dao.base;

import java.lang.reflect.Field;
import java.util.Date;
import java.util.UUID;

import ${packagename}.annotations.dbmodel.interpreter.Interpreter;
import ${packagename}.util.AfReflecter;

/**
 * 通用Dao实现基类
 * @param <T>
 * @author ${author}
 * @date ${.now?string("yyyy-MM-dd HH:mm:ss zzzz")}
 */
public class BaseDaoImpl<T> extends BaseDaoDbUtilMYSQLImpl<T> implements BaseDao<T>{

	public BaseDaoImpl() {
		// TODO Auto-generated constructor stub
		//order = "ORDER BY createTime DESC";
	}
	
	@Override
	public int insert(T t) throws Exception {
		checkNullID(t);
		AfReflecter.setMemberNoException(t, "createTime", new Date());
		AfReflecter.setMemberNoException(t, "updateTime", new Date());
		return super.insert(t);
	}
	
	@Override
	public int update(T t) throws Exception {
		AfReflecter.setMemberNoException(t, "updateTime", new Date());
		return super.update(t);
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
	
}
