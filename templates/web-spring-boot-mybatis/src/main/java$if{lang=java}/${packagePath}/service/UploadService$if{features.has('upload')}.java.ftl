package ${packageName}.service;

import ${packageName}.constant.ResultCode;
import ${packageName}.constant.UploadType;
import ${packageName}.exception.ServiceException;
import ${packageName}.mapper.UploadMapper;
import ${packageName}.model.api.Upload;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.catalina.util.URLEncoder;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.lang.NonNull;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import static ${packageName}.service.HostService.urlSchemeHostPort;

/**
 * 文件上传服务
 *
 * 由代码生成器生成，可以修改
 * 但是如果删除，下次继续生成时，又会出现
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Slf4j
@Service
@AllArgsConstructor
public class UploadService {

    private final DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");

    private final UploadMapper mapper;

    /**
     * 根据 图片id 删除图片信息
     * @param id 图片id
     */
    public void deleteUploadById(@Nullable String id) {
        if (id == null || id.startsWith("http")) {
            return;
        }

        File file = findFileById(id);
        if (file != null && !file.delete()) {
            log.warn("deleteUploadById.file.delete=false:{}", file.getAbsolutePath());
        }

        int deleted = mapper.deleteById(id);
        if (deleted != 1) {
            log.warn("deleteUploadById({})={}", id, deleted);
        }
    }

    /**
     * 根据图片 id 获取文件
     * @param id 图片 id
     * @return file or null
     */
    @Nullable
    public File findFileById(String id) {
        Upload upload = mapper.findById(id);
        if (upload != null) {
            return getFileByUpload(upload);
        } else {
            log.warn("findFileById.findById=null:{}", id);
        }
        return null;
    }

    /**
     * 根据 Upload 获取文件
     * @param upload 上传信息
     * @return file
     */
    @NonNull
    public File getFileByUpload(Upload upload) {
<#if hasStringId>
        return new File(new File("upload", upload.getPath()), upload.getId()).getAbsoluteFile();
<#else >
        return new File(new File("upload", upload.getPath()), String.valueOf(upload.getId())).getAbsoluteFile();
</#if>
    }

    /**
     * 根据类型和用户生成上传文件的保存路径
     * @param account   账户
     * @param type      类型
     * @return path
     */
    public String pathWith(@Nullable String account, UploadType type) {
        if (type.ordinal() > UploadType.image.ordinal() && account != null) {
            return String.format("%s/%s/%s", type.name(), account, dateFormat.format(new Date()));
        }
        return String.format("%s/%s", type.name(), dateFormat.format(new Date()));
    }

    /**
     * 根据 upload 对象配置，把文件保存到服务器目录
     * @param part   文件对象
     * @param upload 上传配置
     */
    public void saveFile(MultipartFile part, Upload upload) {
        File file = getFileByUpload(upload);
        File parent = file.getParentFile();
        if (!parent.exists() && !parent.mkdirs()) {
            log.error("创建目录失败:" + parent.getAbsolutePath());
            throw new ServiceException(ResultCode.FailToMkdirUpload);
        }
        try {
            part.transferTo(file);
        } catch (IOException e) {
            log.error("保存文件失败", e);
            throw new ServiceException(ResultCode.FailToWriteUpload);
        }
        mapper.insert(upload);
    }


    /**
     * 接受上传文件并存储
     * @param multipart 表单文件
     * @param request HTTP 请求
     */
    public synchronized Upload upload(MultipartFile multipart, HttpServletRequest request) {
        Upload upload = new Upload(multipart);
        upload.setPath(this.pathWith(null, UploadType.from(multipart)));
        this.saveFile(multipart, upload);
<#if hasStringId>
        upload.setPath(urlWithToken(request, upload.getId()));
<#else >
        upload.setPath(urlWithToken(request, String.valueOf(upload.getId())));
</#if>
        return upload;
    }

    /**
     * 文件下载
     * @param id 文件ID
     * @param request Http请求
     */
    public ResponseEntity<FileSystemResource> download(Object id, HttpServletRequest request) {
        Upload upload = mapper.findById(id);
        if (upload == null) {
            throw new ClientException(ResultCode.LostUploadData);
        }

        File file = this.getFileByUpload(upload);
        if (!file.exists()) {
            throw new ServiceException(ResultCode.LostUploadFile);
        }

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.parseMediaType(upload.getMimeType()));
        if (request.getServletPath().contains("download")) {
            String name = URLEncoder.QUERY.encode(upload.getName(), StandardCharsets.UTF_8);
            headers.setContentDispositionFormData("attachment", name);
        }
        return new ResponseEntity<>(new FileSystemResource(file), headers, HttpStatus.OK);
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
        return String.format("%s/api/v1/file/download/%s", urlSchemeHostPort(request), token);
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
