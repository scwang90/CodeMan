package ${packageName}.service;

import ${packageName}.constant.UploadType;
import ${packageName}.exception.ServiceException;
import ${packageName}.mapper.UploadMapper;
import ${packageName}.model.api.Upload;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.lang.NonNull;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 文件上传服务
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Service
public class UploadService {

    private Logger logger = LoggerFactory.getLogger(getClass());
    private DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");

    private final UploadMapper mapper;

    public UploadService(UploadMapper mapper) {
        this.mapper = mapper;
    }

    /**
     * 根据 图片token 删除图片信息
     *
     * @param token 图片token
     */
    public void deleteUploadByToken(@Nullable String token) {
        if (token == null || token.startsWith("http")) {
            return;
        }

        File file = findFileByToken(token);
        if (file != null && !file.delete()) {
            logger.warn("deleteUploadByToken.file.delete=false:{}", file.getAbsolutePath());
        }

        int deleted = mapper.deleteByToken(token);
        if (deleted != 1) {
            logger.warn("deleteUploadByToken({})={}", token, deleted);
        }
    }

    /**
     * 根据图片 token 获取文件
     * @param token 图片 token
     * @return file or null
     */
    @Nullable
    public File findFileByToken(String token) {
        Upload upload = mapper.findByToken(token);
        if (upload != null) {
            return getFileByUpload(upload);
        } else {
            logger.warn("findFileByToken.findByToken=null:{}", token);
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
        return new File(new File("upload", upload.path), upload.token).getAbsoluteFile();
    }

    /**
     * 根据类型和用户生成上传文件的保存路径
     *
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
     *
     * @param part   文件对象
     * @param upload 上传配置
     */
    public void saveFile(MultipartFile part, Upload upload) {
        File file = getFileByUpload(upload);
        File parent = file.getParentFile();
        if (!parent.exists() && !parent.mkdirs()) {
            logger.error("创建目录失败:" + parent.getAbsolutePath());
            throw new ServiceException("上传失败");
        }
        try {
            part.transferTo(file);
        } catch (IOException e) {
            logger.error("保存文件失败", e);
            throw new ServiceException("上传失败");
        }
        mapper.insert(upload);
    }
}
