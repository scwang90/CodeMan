package ${packageName}.controller;

import ${packageName}.constant.ResultCode;
import ${packageName}.model.api.ApiResult;
import ${packageName}.model.api.LoginInfo;
import ${packageName}.service.AuthService;
import ${packageName}.shiro.JwtBearer;
import ${packageName}.util.JwtUtils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.DigestUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import springfox.documentation.annotations.ApiIgnore;

/**
 * 登录验证 API 实现
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Validated
@RestController
@Api(tags = "登录验证API")
@RequestMapping("/api/v1/auth")
public class AuthController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    private final AuthService service;

    public ApiAuthController(AuthService service) {
        this.service = service;
    }

    @PostMapping("login")
    @ApiOperation(value = "登录", notes = "后台管理相关API都需要先登录")
    @ApiImplicitParams({
        @ApiImplicitParam(paramType = "form", value = "登录账户", name = "username", required = true, defaultValue = "admin"),
        @ApiImplicitParam(paramType = "form", value = "登录密码", name = "password", required = true, defaultValue = "admin"),
    })
    public ApiResult<LoginInfo> login(String username, String password, @ApiIgnore HttpServletRequest request, @ApiIgnore HttpServletResponse response) throws Throwable {
        try {
            LoginInfo info = service.login(username, password);
            JwtUtils.writeToHeader(info.token, request, response);
            return ApiResult.success(info);
        } catch (AuthenticationException e) {
            if (e.getCause() != null) {
                throw e.getCause();
            }
            logger.error("登录失败", e);
            return ApiResult.failure400("登录失败");
        }
    }

    @PostMapping("status")
    @ApiOperation(value = "登录状态")
    public ApiResult<Object> status() {
        Subject subject = SecurityUtils.getSubject();
        JwtBearer bearer = subject.getPrincipals().oneByType(JwtBearer.class);
        logger.info("userId=" + bearer.userId);
        return ApiResult.success(Arrays.asList(subject.getPrincipals().oneByType(JwtBearer.class),subject.getPrincipals().oneByType(DecodedJWT.class)));
    }

    @ApiOperation(value = "请先登录", hidden = true)
    @RequestMapping("failed")
    public ApiResult<Object> failed() {
        return new ApiResult<>(null, ResultCode.C401.code, ResultCode.C401.remark);
    }

    @ApiIgnore
    @ApiOperation(value = "凭证过期", hidden = true)
    @RequestMapping("expired")
    public ApiResult<Object> expired() {
        return new ApiResult<>(null, ResultCode.C403.code, ResultCode.C403.remark);
    }
}
