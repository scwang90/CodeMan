package ${packagename}.dao.base;

import java.util.Date;

import ${packagename}.util.AfReflecter;

public class BaseDaoImpl<T> extends BaseDaoDbUtilImpl<T> implements BaseDao<T>{

	public BaseDaoImpl() {
		// TODO Auto-generated constructor stub
		order = "ORDER BY createDate DESC";
	}
	
	@Override
	public int insert(T t) throws Exception {
		// TODO Auto-generated method stub
		AfReflecter.setMemberNoException(t, "createDate", new Date());
		AfReflecter.setMemberNoException(t, "updateDate", new Date());
		return super.insert(t);
	}
	
	@Override
	public int update(T t) throws Exception {
		// TODO Auto-generated method stub
		AfReflecter.setMemberNoException(t, "updateDate", new Date());
		return super.update(t);
	}
}
