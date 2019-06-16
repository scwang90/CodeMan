package ${packageName}.util;

import java.util.ArrayList;
import java.util.List;

/**
 * @Description: 数据分页列表信息
 * @param <T> 数据实体类
 * @author ${author}
 * @date ${.now?string("yyyy-MM-dd zzzz")}
 */
public abstract class Page<T>{
	
	private int currentPage = 0; 
	private int pageSize = 0;
	private int totalPage = 0;
	private int totalRecord = 0; 
	
	private List<T> datas = new ArrayList<T>();
	
	public Page() {
	}
	
	public Page(int currentPage, int pageSize, int totalPage, int totalRecord,
			List<T> datas) {
		super();
		this.currentPage = currentPage;
		this.pageSize = pageSize;
		this.totalPage = totalPage;
		this.totalRecord = totalRecord;
		this.datas = datas;
	}

	public Page(List<T> all) {
		super();
		this.currentPage = 0;
		this.pageSize = all.size();
		this.totalPage = 1;
		this.totalRecord = all.size();
		this.datas = all;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getTotalRecord() {
		return totalRecord;
	}

	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
	}

	public List<T> getDatas() {
		return datas;
	}

	public void setDatas(List<T> datas) {
		this.datas = datas;
	}
	
	
}
