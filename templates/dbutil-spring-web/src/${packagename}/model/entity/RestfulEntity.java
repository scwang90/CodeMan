package ${packagename}.model.entity;

import java.io.Serializable;

/**
 * Restful返回实体类
 * @author ${author}
 * @date ${.now?string("yyyy-MM-dd HH:mm:ss zzzz")} 
 */
public class RestfulEntity implements Serializable {

	private static final long serialVersionUID = 7003037513889860450L;

	private boolean result;

	private Object data;

	public RestfulEntity(Object data, boolean result) {
		this.result = result;
		this.data = data;
	}

	/**
	 * 返回成功信息
	 * 
	 * @param mes
	 * @return String
	 */
	public static RestfulEntity getSuccess(Object mes) {
		return new RestfulEntity(mes, true);
	}

	/**
	 * 返回失败信息
	 * 
	 * @param mes
	 * @return String
	 */
	public static RestfulEntity getFailure(Object mes) {
		return new RestfulEntity(mes, false);
	}

	public boolean isResult() {
		return result;
	}

	public void setResult(boolean result) {
		this.result = result;
	}

	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}
}
