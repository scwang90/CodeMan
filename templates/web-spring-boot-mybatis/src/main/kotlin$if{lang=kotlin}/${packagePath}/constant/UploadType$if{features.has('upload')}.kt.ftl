package ${packageName}.constant

import org.springframework.web.multipart.MultipartFile

/**
 * 上传文件类型
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
enum class UploadType(val value: String) {
    File("file"),
    Image("image"),
    Avatar("avatar");
    
    companion object {
        fun from(file: MultipartFile): UploadType {
            if (file?.contentType?.startsWith("image") == true) {
                return Image
            }
            return File
        }
    }
}
