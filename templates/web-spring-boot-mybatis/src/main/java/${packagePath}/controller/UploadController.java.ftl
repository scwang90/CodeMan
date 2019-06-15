package ${packageName}.controller;

import ${packageName}.constant.UploadType;
import ${packageName}.exception.ServiceException;
import ${packageName}.mapper.UploadMapper;
import ${packageName}.model.api.Upload;
import ${packageName}.util.ID22;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 文件上传接口
 * @author ${author}
 * @date ${.now?string("yyyy-MM-dd HH:mm:ss zzzz")}
 */
@Controller
@RequestMapping("/api/v1/upload")
public class UploadController {

	@Autowired
	UploadMapper mapper;

	DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");

	//处理文件上传
	@ResponseBody
	@PostMapping(value="upload")
	public Object upload(@RequestParam("file") MultipartFile file, HttpServletRequest request) throws Exception {
		String fileName = file.getOriginalFilename();

		Upload uploadFile = new Upload();
		uploadFile.type = UploadType.file.ordinal();
		uploadFile.name = fileName;
		uploadFile.time = new Date();
		uploadFile.id = ID22.randomID22();

		String path = String.format("%s/%s/%s", UploadType.file.name(), dateFormat.format(uploadFile.time), uploadFile.id);
		File upload = new File(String.format("%s/%s", request.getSession().getServletContext().getRealPath("upload"), path));

		File parent = upload.getParentFile();
		if(!parent.exists() && !parent.mkdirs()){
			throw new ServiceException("创建上传目录失败:" + parent.getAbsolutePath());
		}

		try (FileOutputStream out = new FileOutputStream(upload)) {
			out.write(file.getBytes());
		}

		uploadFile.path = path;
		mapper.insert(uploadFile);
		return String.format("%s://%s:%s/api/v1/file/download/%s", request.getScheme(), request.getServerName(), request.getServerPort(), uploadFile.id);
	}

	@RequestMapping("download/{token}")
	public ResponseEntity<byte[]> download(@PathVariable String token, HttpServletRequest request) throws IOException {

		Upload upload = mapper.findByToken(token);
		if (upload == null) {
			throw new ServiceException("找不到对应文件");
		}

		File file = new File(String.format("%s/%s", request.getSession().getServletContext().getRealPath("upload"), upload.path));
		if (!file.exists()) {
			throw new ServiceException("找不到对应文件");
		}

		HttpHeaders headers = new HttpHeaders();
		headers.setContentDispositionFormData("attachment", upload.name);
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);

		try (InputStream input = new FileInputStream(file)) {
			byte[] bytes = new byte[input.available()];
			input.read(bytes);
			return new ResponseEntity<>(bytes, headers, HttpStatus.CREATED);
		}

	}

}
