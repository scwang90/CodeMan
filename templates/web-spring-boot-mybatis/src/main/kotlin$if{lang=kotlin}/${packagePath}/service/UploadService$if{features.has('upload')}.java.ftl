package ${packageName}.service

import ${packageName}.constant.UploadType
import ${packageName}.exception.ServiceException
import ${packageName}.mapper.UploadMapper
import ${packageName}.model.api.Upload
import org.springframework.stereotype.Service
import org.springframework.web.multipart.MultipartFile

import java.io.File
import java.io.IOException
import java.text.DateFormat
import java.text.SimpleDateFormat
import java.util.Date

/**
 * 文件上传服务
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Service
class UploadService {

    private val log = LoggerFactory.getLogger(this.javaClass)

    private val dateFormat = SimpleDateFormat("yyyyMMdd")

	@Autowired
	private lateinit var mapper: UploadMapper

    /**
     * 根据 图片id 删除图片信息
     * @param id 图片id
     */
    fun deleteUploadById(id: String?) {
        if (id == null || id.startsWith("http")) {
            return
        }
        val file = findFileById(id)
        if (file != null && !file.delete()) {
            log.warn("deleteUploadById.file.delete=false:{}", file.getAbsolutePath())
        }
        val deleted: Int = mapper.deleteById(id)
        if (deleted != 1) {
            log.warn("deleteUploadById({})={}", id, deleted)
        }
    }

    /**
     * 根据图片 id 获取文件
     * @param id 图片 id
     * @return file or null
     */
    fun findFileById(id: String?): File? {
        val upload: Upload = mapper.findById(id)
        if (upload != null) {
            return getFileByUpload(upload)
        } else {
            log.warn("findFileById.findById=null:{}", id)
        }
        return null
    }

    /**
     * 根据 Upload 获取文件
     * @param upload 上传信息
     * @return file
     */
    fun getFileByUpload(upload: Upload): File {
        return File(File("upload", upload.getPath()), upload.getId()).getAbsoluteFile()
    }

    /**
     * 根据类型和用户生成上传文件的保存路径
     * @param account   账户
     * @param type      类型
     * @return path
     */
    fun pathWith(account: String?, type: UploadType): String? {
        return if (type.ordinal() > UploadType.image.ordinal() && account != null) {
            String.format("%s/%s/%s", type.name(), account, dateFormat.format(Date()))
        } else String.format("%s/%s", type.name(), dateFormat.format(Date()))
    }

    /**
     * 根据 upload 对象配置，把文件保存到服务器目录
     * @param part   文件对象
     * @param upload 上传配置
     */
    fun saveFile(part: MultipartFile, upload: Upload) {
        val file = getFileByUpload(upload)
        val parent = file.getParentFile()
        if (!parent.exists() && !parent.mkdirs()) {
            log.error("创建目录失败:" + parent.getAbsolutePath())
            throw ServiceException("上传失败")
        }
        try {
            part.transferTo(file)
        } catch (e: IOException) {
            log.error("保存文件失败", e)
            throw ServiceException("上传失败")
        }
        mapper.insert(upload)
    }
    
}
