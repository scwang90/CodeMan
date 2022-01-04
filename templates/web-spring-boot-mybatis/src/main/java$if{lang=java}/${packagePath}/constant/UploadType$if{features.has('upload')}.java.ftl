package ${packageName}.constant;

import org.springframework.web.multipart.MultipartFile;

/**
 * 文件类型
 *
 * 由代码生成器生成，可以修改
 * 但是如果删除，下次继续生成时，又会出现
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
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

    public static UploadType from(int type) {
        UploadType[] values = UploadType.values();
        if (values.length > type) {
            return values[type];
        }
        return UploadType.file;
    }
}
