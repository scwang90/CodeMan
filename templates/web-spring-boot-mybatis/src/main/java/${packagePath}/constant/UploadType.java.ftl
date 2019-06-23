package ${packageName}.constant;

import org.springframework.web.multipart.MultipartFile;

/**
 * 文件类型
 * @author ${author}
 * @since ${.now?string("yyyy-MM-dd zzzz")}
 */
public enum UploadType implements ShortEnum {
    file,image,avatar;
    
    public static UploadType from(MultipartFile file) {
        String type = file.getContentType();
        if (type != null && type.startsWith("image")) {
            return UploadType.image;
        }
        return UploadType.file;
    }
}
