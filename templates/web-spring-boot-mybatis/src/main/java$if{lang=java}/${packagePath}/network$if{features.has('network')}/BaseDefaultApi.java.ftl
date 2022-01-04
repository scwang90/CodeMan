package ${packageName}.network;

import ${packageName}.constant.ResultCode;
import ${packageName}.exception.ServiceException;
import ${packageName}.model.api.ApiResult;
import retrofit2.HttpException;
import retrofit2.Response;

/**
 * API返回默认处理封装
 *
 * 由代码生成器生成，可以修改
 * 但是如果删除，下次继续生成时，又会出现
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public class BaseDefaultApi {

    static  <T> T verify(Response<T> response) {
        if (!response.isSuccessful()) {
            throw new ServiceException(ResultCode.RemoteServerFailCode, new HttpException(response));
        }
        T result = response.body();
        if (result == null) {
            throw new ServiceException(ResultCode.RemoteServerReturnEmpty);
        }
        return result;
    }

    static <T> T verifyResult(Response<ApiResult<T>> response) {
        return verifyResult(response, "服务");
    }

    static <T> T verifyResult(Response<ApiResult<T>> response, String serverName) {
        return verify(response).result(true, serverName);
    }
}
