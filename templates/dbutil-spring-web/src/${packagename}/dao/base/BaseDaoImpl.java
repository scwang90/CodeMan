package ${packagename}.dao.base;

//import java.util.Date;

//import ${packagename}.util.AfReflecter;
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
		// TODO Auto-generated method stub
		//AfReflecter.setMemberNoException(t, "createTime", new Date());
		//AfReflecter.setMemberNoException(t, "updateDate", new Date());
		return super.insert(t);
	}
	
	@Override
	public int update(T t) throws Exception {
		// TODO Auto-generated method stub
		//AfReflecter.setMemberNoException(t, "updateDate", new Date());
		return super.update(t);
	}
}
