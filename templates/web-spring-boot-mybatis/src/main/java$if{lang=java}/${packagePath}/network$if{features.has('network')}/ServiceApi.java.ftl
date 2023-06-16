package ${packageName}.network;

import ${packageName}.model.api.ApiResult;
import retrofit2.Call;
import retrofit2.Response;
import retrofit2.http.*;

import java.util.Map;

/**
 * 服务API接口定义
 *
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public interface ServiceApi {

    default <T> T verifyResult(Response<ApiResult<T>> response) {
        return BaseDefaultApi.verifyResult(response, "用户中心服务");
    }

    @POST("api/v1/request")
    Call<ApiResult<Object>> request(@Header("x-sign") String sign, @Body Map<String, String> body);

}
