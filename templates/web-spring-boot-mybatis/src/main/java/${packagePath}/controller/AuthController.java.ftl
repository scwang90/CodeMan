package ${packageName}.controller;

import ${packageName}.constant.CommonApi;
import ${packageName}.constant.ResultCode;
import ${packageName}.constant.UserType;
import ${packageName}.exception.ServiceException;
import ${packageName}.model.api.ApiResult;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

import springfox.documentation.annotations.ApiIgnore;
import javax.servlet.http.HttpSession;

/**
 * 登录验证 API 实现
 * @author ${author}
 * @date ${.now?string("yyyy-MM-dd zzzz")}
 */
@CommonApi
@RestController
@Api(value = "auth", description = "管理员登录验证API")
@RequestMapping("/api/v1/auth")
public class AuthController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

//    @Autowired
//    private AdminMapper mapper;

    @PostMapping("login")
    @ApiOperation(value = "管理员登录", notes = "后台管理相关API都需要先登录")
    @ApiImplicitParams({
        @ApiImplicitParam(paramType = "form", value = "登录名", name = "username", required = true, defaultValue = "admin"),
        @ApiImplicitParam(paramType = "form", value = "登录密码", name = "password", required = true, defaultValue = "admin")
    })
    public ApiResult<Object/*Admin*/> login(String username, StringBuilder password, @ApiIgnore HttpSession session) {
        String md5 = DigestUtils.md5DigestAsHex(password.toString().getBytes());
        logger.debug("密文：" + md5);
        password.setLength(0);
        password.append(md5);

//        if (mapper.countAll() == 0) {
//            Admin admin = new Admin();
//            admin.username = "admin";
//            admin.password = DigestUtils.md5DigestAsHex("admin".getBytes());
//            mapper.insert(admin);
//        }
//        List<Admin> list = mapper.findWhereByPage("", "WHERE username='$username' AND password='$password'", 1, 0);

        List<String> list = new ArrayList<>();
        if ("admin".equals(username) && DigestUtils.md5DigestAsHex("admin".getBytes()).equals(password.toString())) {
            list.add("超级管理员");
        }
        if (list.isEmpty()) {
            throw new ServiceException("用户名或密码错误");
        } else {
            session.setAttribute(UserType.Admin.name(), list.get(0));
            return ApiResult.success(list.get(0));
        }
    }

    @ApiOperation(value = "管理员注销登录")
    @GetMapping("logout")
    public ApiResult<String> logout(@ApiIgnore HttpSession session) {
        if (session.getAttribute(UserType.Admin.name()) != null) {
            session.removeAttribute(UserType.Admin.name());
            return ApiResult.success("注销登录成功");
        } else {
            throw new ServiceException("请先登录");
        }
    }

    @ApiOperation(value = "请先登录", hidden = true)
    @RequestMapping("failed")
    public ApiResult<Object> failed() {
        return new ApiResult<>(null, ResultCode.C401.code, ResultCode.C401.remark);
    }

}
