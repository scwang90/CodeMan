package ${packageName}.controller;

import ${packageName}.constant.UploadType;
import ${packageName}.exception.ServiceException;
import ${packageName}.mapper.UploadMapper;
import ${packageName}.model.api.ApiResult;
import ${packageName}.model.api.Upload;
import ${packageName}.service.UploadService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.AllArgsConstructor;
import org.apache.catalina.util.URLEncoder;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.*;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.nio.charset.StandardCharsets;

import static ${packageName}.controller.HostController.urlSchemeHostPort;

/**
 * 文件上传接口
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Validated
@Controller
@AllArgsConstructor
@Api(tags = "文件上传")
@RequestMapping("/api/v1/file")
public class UploadController {

	private final UploadMapper mapper;
	private final UploadService service;

	//处理文件上传
	@ResponseBody
	@ApiOperation(value = "文件上传")
	@PostMapping(value = "upload")
	public synchronized ApiResult<Upload> upload(@RequestParam("file") @ApiParam("上传文件") MultipartFile multipart, HttpServletRequest request) {
		Upload upload = new Upload(multipart);
		upload.setPath(service.pathWith(null, UploadType.from(multipart)));
		service.saveFile(multipart, upload);
		upload.setPath(downloadUrlWithToken(request, upload.getId()));
		return ApiResult.success(upload);
	}

	/**
	 * 文件预览
	 */
	@ApiOperation(value = "文件预览")
	@GetMapping(preview/{id})
	public ResponseEntity<FileSystemResource> preview(@PathVariable String id, HttpServletRequest request)  {
		Upload upload = mapper.findById(id);
		if (upload == null) {
			throw new ServiceException("找不到对应文件信息");
		}

		File file = service.getFileByUpload(upload);
		if (!file.exists()) {
			throw new ServiceException("找不到对应文件");
		}

		HttpHeaders headers = new HttpHeaders();
		String name = URLEncoder.QUERY.encode(upload.getName(), StandardCharsets.UTF_8);
		headers.setContentType(MediaType.parseMediaType(upload.getMimeType()));
		headers.setContentDisposition(ContentDisposition.inline().filename(name).build());
		return new ResponseEntity<>(new FileSystemResource(file), headers, HttpStatus.OK);
	}

	/**
	* 文件下载
	*/
	@ApiOperation(value = "文件下载")
	@GetMapping("download/{id}")
	public ResponseEntity<FileSystemResource> download(@PathVariable String id, HttpServletRequest request) {
		ResponseEntity<FileSystemResource> entity = preview(id, request);
		HttpHeaders headers = new HttpHeaders(entity.getHeaders());
		String name = entity.getHeaders().getContentDisposition().getFilename() + "";
		headers.setContentDisposition(ContentDisposition.attachment().filename(name).build());
		return new ResponseEntity<>(entity.getBody(), headers, HttpStatus.OK);
	}

	/**
	 * 根据图片 token 获取下载链接
	 * @param request 请求对象
	 * @param token 图片 token
	 * @return url
	 */
	public static String downloadUrlWithToken(HttpServletRequest request, @Nullable String token) {
		if (token == null || token.startsWith("http")) {
			return token;
		}
		return String.format("%s/api/v1/file/download/%s", urlSchemeHostPort(request), token);
	}

	/**
	 * 根据图片 token 获取预览链接
	 * @param request 请求对象
	 * @param token 图片 token
	 * @return url
	 */
	public static String previewUrlWithToken(HttpServletRequest request, @Nullable String token) {
		if (token == null || token.startsWith("http")) {
			return token;
		}
		return String.format("%s/api/v1/file/preview/%s", urlSchemeHostPort(request), token);
	}

	/**
	 * 根据图片Url 获取图片 token
	 * @param request 请求对象
	 * @param url 图片Url
	 * @return token
	 */
	public static String tokenWithUrl(HttpServletRequest request, @Nullable String url) {
		if (url == null) {
			return null;
		}
		return url.replace(urlSchemeHostPort(request) + "/api/v1/file/download/", "");
	}

}
