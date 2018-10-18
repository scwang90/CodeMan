package ${packageName}.controller

import io.swagger.annotations.Api
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

/**
 * 登录验证 API 实现
 * @author ${author}
 * @date ${.now?string("yyyy-MM-dd HH:mm:ss zzzz")}
 */
@RestController
@Api("auth", description = "登录验证API")
@RequestMapping("/api/v1/auth")
class AuthController {

//    private val logger = LoggerFactory.getLogger(this.javaClass)
//
//    @Autowired
//    private lateinit var mapper : AdminMapper
//
//    @PostMapping("login")
//    @ApiOperation(value = "管理员登录", notes = "后台管理相关API都需要先登录")
//    @ApiImplicitParams(
//        ApiImplicitParam(paramType = "form", value = "登录名", name = "username", required = true, defaultValue = "admin"),
//        ApiImplicitParam(paramType = "form", value = "登录密码", name = "password", required = true, defaultValue = "admin")
//    )
//    fun login(username: String, password: StringBuilder, @ApiIgnore session: HttpSession): ApiResult<Admin>? {
//        password.apply {
//            DigestUtils.md5DigestAsHex(password.toString().byteInputStream()).apply {
//                logger.debug("密文：$this")
//                setLength(0)
//                append(this)
//            }
//        }
//        if (mapper.countAll() == 0) {
//            mapper.insert(Admin().apply {
//                this.username="admin"
//                this.password = DigestUtils.md5DigestAsHex("admin".byteInputStream())
//            })
//        }
//        val list = mapper.findWhereByPage("", "WHERE username='$username' AND password='$password'", 1, 0)
//        if (list.isEmpty()) {
//            throw ServiceException("用户名或密码错误")
//        } else {
//            session.setAttribute(UserType.admin.name, list[0])
//            return ApiResult(result = list[0])
//        }
//    }
//
//    @ApiOperation(value = "管理员注销登录")
//    @GetMapping("logout")
//    fun logout(@ApiIgnore session: HttpSession): ApiResult<String>? {
//        if (session.getAttribute(UserType.admin.name) != null) {
//            session.removeAttribute(UserType.admin.name)
//            return ApiResult.success("注销登录成功")
//        } else {
//            throw ServiceException("请先登录")
//        }
//    }
//
//    @ApiOperation(value = "请先登录", hidden = true)
//    @RequestMapping("failed")
//    fun failed(): Any? {
//        return ApiResult<Any>(null, ResultCode.C401.code, ResultCode.C401.remark)
//    }

}