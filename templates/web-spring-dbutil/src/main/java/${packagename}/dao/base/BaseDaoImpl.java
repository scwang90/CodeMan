package ${packagename}.dao.base;

import ${packagename}.model.base.ModelBase;
import ${packagename}.util.AfReflecter;

import java.util.Date;

/**
 * 通用Dao实现基类
 * @param <T>
 * @author ${author}
 * @date ${.now?string("yyyy-MM-dd HH:mm:ss zzzz")}
 */
public class BaseDaoImpl<T> extends BaseDaoDbUtilMYSQLImpl<T> implements BaseDao<T>{

	public BaseDaoImpl() {
		//order = "ORDER BY createTime DESC";
	}
	
	@Override
	public int insert(T t) throws Exception {
		ModelBase.fillNullID(t);
		AfReflecter.setMemberNoException(t, "createTime", new Date());
		AfReflecter.setMemberNoException(t, "updateTime", new Date());
		return super.insert(t);
	}
	
	@Override
	public int update(T t) throws Exception {
		AfReflecter.setMemberNoException(t, "updateTime", new Date());
		return super.update(t);
	}

}
