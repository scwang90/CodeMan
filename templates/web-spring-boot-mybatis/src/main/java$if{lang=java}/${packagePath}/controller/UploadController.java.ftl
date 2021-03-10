package ${packageName}.controller;

import ${packageName}.constant.UploadType;
import ${packageName}.exception.ServiceException;
import ${packageName}.mapper.UploadMapper;
import ${packageName}.model.api.ApiResult;
import ${packageName}.model.api.Upload;
import ${packageName}.service.UploadService;

import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import springfox.documentation.annotations.ApiIgnore;

/**
 * 文件上传接口
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Validated
@Controller
@Api(value = "user", description = "文件上传API")
@RequestMapping("/api/v1/file")
public class UploadController {

	private final UploadMapper mapper;
	private final UploadService service;

	public UploadController(UploadMapper mapper, UploadService service) {
		this.mapper = mapper;
		this.service = service;
	}

	//处理文件上传
	@ResponseBody
	@ApiOperation(value = "文件上传")
	@PostMapping(value = "upload")
	public ApiResult<Upload> upload(@RequestParam("file") @ApiParam("上传文件") MultipartFile multipart, HttpServletRequest request) {
		Upload upload = new Upload(multipart);
		upload.path = service.pathWith(null, UploadType.from(multipart));
		try {
			service.saveFile(multipart, upload);
			upload.path = request.getRequestURL().toString().replace("upload", "download") + "/" + upload.token;
		} catch (ServiceException e) {
			return ApiResult.failure500("上传失败");
		} catch (Throwable e) {
			e.printStackTrace();
			upload.path = String.format("%s://%s:%d/upload/%s", request.getScheme(), request.getServerName(), request.getServerPort(), upload.path);
		}
		return ApiResult.success(upload);
	}

	@ApiOperation(value = "文件下载")
	@GetMapping("download/{token}")
	public ResponseEntity<FileSystemResource> download(@PathVariable String token, @RequestHeader("User-Agent") @ApiIgnore String userAgent)  {

		Upload upload = mapper.findByToken(token);
		if (upload == null) {
			throw new ServiceException("找不到对应文件信息");
		}

		File file = service.getFileByUpload(upload);
		if (!file.exists()) {
			throw new ServiceException("找不到对应文件");
		}

		HttpHeaders headers = new HttpHeaders();
		if (userAgent != null && userAgent.contains("Mozilla/")) {
			headers.setContentType(MediaType.parseMediaType(upload.mimeType));
		} else {
			headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
			headers.setContentDispositionFormData("attachment", upload.name);
		}
		return new ResponseEntity<>(new FileSystemResource(file), headers, HttpStatus.CREATED);

	}

	/**
	 * 根据图片 token 获取下载链接
	 * @param request 请求对象
	 * @param token 图片 token
	 * @return url
	 */
	public static String urlWithToken(HttpServletRequest request, @Nullable String token) {
		if (token == null || token.startsWith("http")) {
			return token;
		}
		return String.format("%s://%s:%d/api/app/file/download/%s", request.getScheme(), request.getServerName(), request.getServerPort(), token);
	}
}
