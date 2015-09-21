package ${packagename}.util;

/**
 * Controller 返回实体类
 * @author ${author}
 * @date ${.now?string("yyyy-MM-dd HH:mm:ss zzzz")}
 */
public class ResultUtil {

	private boolean result;

	private Object data;

	public ResultUtil(Object data, boolean result) {
		this.result = result;
		this.data = data;
	}

	/**
	 * 返回成功信息
	 * 
	 * @param mes
	 * @return String
	 */
	public static String getSuccess(Object mes) {
		return JacksonUtil.toJson(new ResultUtil(mes, true));
	}

	/**
	 * 返回失败信息
	 * 
	 * @param mes
	 * @return String
	 */
	public static String getFailure(Object mes) {
		return JacksonUtil.toJson(new ResultUtil(mes, false));
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
