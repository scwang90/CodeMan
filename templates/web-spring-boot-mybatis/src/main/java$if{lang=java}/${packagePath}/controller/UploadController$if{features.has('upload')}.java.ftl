package ${packageName}.controller;

import ${packageName}.model.api.ApiResult;
import ${packageName}.model.api.Upload;
import ${packageName}.service.UploadService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.AllArgsConstructor;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.*;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;


/**
 * 文件上传接口
 *
 * 由代码生成器生成，可以修改
 * 但是如果删除，下次继续生成时，又会出现
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Validated
@Controller
@AllArgsConstructor
@Api(tags = "文件上传")
@RequestMapping("/api/v1/file")
public class UploadController {

	private final UploadService service;

	@ResponseBody
	@ApiOperation(value = "文件上传")
	@PostMapping(value = "upload")
	public ApiResult<Upload> upload(@RequestParam("file") @ApiParam("上传文件") MultipartFile multipart, HttpServletRequest request) {
		return ApiResult.success(service.upload(multipart, request));
	}

	@ApiOperation(value = "文件预览")
	@GetMapping("preview/{id}")
	public ResponseEntity<FileSystemResource> preview(@PathVariable String id, HttpServletRequest request)  {
		return service.download(id, request);
	}

	@ApiOperation(value = "文件下载")
	@GetMapping("download/{id}")
	public ResponseEntity<FileSystemResource> download(@PathVariable String id, HttpServletRequest request)  {
		return service.download(id, request);
	}

}
