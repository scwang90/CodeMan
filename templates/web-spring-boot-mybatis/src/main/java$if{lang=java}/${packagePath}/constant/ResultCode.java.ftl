package ${packageName}.constant;

import org.springframework.http.HttpStatus;

/**
 * 统一返回错误代码
 *
 * 由代码生成器生成，可以修改
 * 但是如果删除，下次继续生成时，又会出现
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public enum ResultCode {

    OK(HttpStatus.OK.value(), "请求成功"),
    BadRequest(HttpStatus.BAD_REQUEST.value(), "客户端错误"),
    Unauthorized(HttpStatus.UNAUTHORIZED.value(), "请先登录"),
    Forbidden(HttpStatus.FORBIDDEN.value(), "凭证过期"),
    NotFound(HttpStatus.NOT_FOUND.value(), "未找到路径"),
    ServerError(HttpStatus.INTERNAL_SERVER_ERROR.value(), "服务器错误"),

    FailToMkdirUpload(521, "创建上传目录失败"),
    FailToWriteUpload(521, "写入上传文件失败"),
    LostUploadData(522, "上传数据丢失"),
    LostUploadFile(523, "上传文件丢失"),
    LostToDeleteFile(524, "文件删除失败"),
<#if features.has('network')>

    RemoteServerFailCode(531, "远程服务器返失败状态码"),
    RemoteServerReturnEmpty(532, "远程服务器返回空")
</#if>
    ;

    public final int code;
    public final String message;

    ResultCode(int code, String message) {
        this.code = code;
        this.message = message;
    }
}
