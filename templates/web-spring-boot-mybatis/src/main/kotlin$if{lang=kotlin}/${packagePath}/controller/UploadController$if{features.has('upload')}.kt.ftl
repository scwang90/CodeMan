package ${packageName}.controller

import ${packageName}.constant.UploadType
import ${packageName}.controller.HostController.Companion.urlSchemeHostPort
import ${packageName}.exception.ServiceException
import ${packageName}.mapper.UploadMapper
import ${packageName}.model.api.ApiResult
import ${packageName}.model.api.Upload
import ${packageName}.service.UploadService
import io.swagger.annotations.Api
import io.swagger.annotations.ApiOperation
import io.swagger.annotations.ApiParam
import org.apache.catalina.util.URLEncoder
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.core.io.FileSystemResource
import org.springframework.http.HttpHeaders
import org.springframework.http.HttpStatus
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity
import org.springframework.stereotype.Controller
import org.springframework.validation.annotation.Validated
import org.springframework.web.bind.annotation.*
import org.springframework.web.multipart.MultipartFile

import javax.servlet.http.HttpServletRequest
import java.nio.charset.StandardCharsets

/**
 * 文件上传接口
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Validated
@Controller
@Api(tags = ["文件上传"], description = "上传 Multipart，暂不支持上传")
@RequestMapping("/api/v1/file")
class UploadController {

	@Autowired
	private lateinit var service: UploadService
	@Autowired
	private lateinit var mapper: UploadMapper

	//处理文件上传
	@ResponseBody
	@Synchronized
	@ApiOperation(value = "文件上传")
	@PostMapping(value = ["upload"])
	fun upload( @RequestParam("file") @ApiParam("上传文件") multipart: MultipartFile, request: HttpServletRequest): ApiResult<Upload> {
		val upload = Upload(multipart)
		upload.path = service.pathWith(null, UploadType.from(multipart))
		service.saveFile(multipart, upload)
		upload.path = urlWithToken(request, upload.id)
		return ApiResult.success(upload)
	}

	@ApiOperation(value = "文件下载")
	@GetMapping(value = ["download/{id}", "view/{id}"])
	fun download(@PathVariable id: String, request: HttpServletRequest): ResponseEntity<FileSystemResource> {
		val upload = mapper.findById(id) ?: throw ServiceException("找不到对应文件信息")
		val file = service.getFileByUpload(upload)
		if (!file.exists()) {
			throw ServiceException("找不到对应文件")
		}
		val headers = HttpHeaders()
		headers.contentType = MediaType.parseMediaType(upload.mimeType ?: "image/png")
		if (request.servletPath.contains("download")) {
			val name: String = URLEncoder.QUERY.encode(upload.name, StandardCharsets.UTF_8)
			headers.setContentDispositionFormData("attachment", name)
		}
		return ResponseEntity<FileSystemResource>(FileSystemResource(file), headers, HttpStatus.OK)
	}

	/**
	 * 根据图片 token 获取下载链接
	 * @param request 请求对象
	 * @param token 图片 token
	 * @return url
	 */
	fun urlWithToken(request: HttpServletRequest, token: String?): String? {
		return if (token == null || token.startsWith("http")) {
				token
			} else java.lang.String.format("%s/api/v1/file/download/%s", urlSchemeHostPort(request), token)
		}

	/**
	 * 根据图片Url 获取图片 token
	 * @param request 请求对象
	 * @param url 图片Url
	 * @return token
	 */
	fun tokenWithUrl(request: HttpServletRequest, url: String?): String? {
		return url?.replace(urlSchemeHostPort(request).toString() + "/api/v1/file/download/", "")
	}

}
