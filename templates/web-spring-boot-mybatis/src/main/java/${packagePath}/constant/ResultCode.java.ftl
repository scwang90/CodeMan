package ${packageName}.constant;

/**
 * 统一返回错误代码
 * @author ${author}
 * @since ${.now?string("yyyy-MM-dd zzzz")}
 */
public enum ResultCode {
    C200(200, "请求成功"),
    C400(400, "客户端错误"),
    C401(401, "请先登录"),
    C404(404, "未找到路径"),
    C500(500, "服务器错误");

    public final int code;
    public final String remark;

    ResultCode(int code, String remark) {
        this.code = code;
        this.remark = remark;
    }
}
