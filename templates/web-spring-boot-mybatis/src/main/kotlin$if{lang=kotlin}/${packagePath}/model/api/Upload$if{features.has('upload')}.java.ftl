package ${packageName}.model.api

import ${packageName}.constant.UploadType.Companion.from
import ${packageName}.util.ID22
import io.swagger.annotations.ApiModel
import io.swagger.annotations.ApiModelProperty
import org.springframework.web.multipart.MultipartFile
import java.util.*

/**
 * 文件上传实体
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@ApiModel(description = "上传文件")
class Upload {
    @ApiModelProperty("文件类型")
    var type = 0

    @ApiModelProperty("文件大小")
    var size: Long = 0

    @ApiModelProperty("文件 Id")
    var id: String? = null

    @ApiModelProperty("文件名称")
    var name: String? = null

    @ApiModelProperty("存储路径")
    var path: String? = null

    @ApiModelProperty("媒体类型")
    var mimeType: String? = null

    @ApiModelProperty("上传日期时间")
    var time: Date? = null

    constructor() {}
    constructor(type: Int) {
        this.type = type
        time = Date()
        id = ID22.random()
    }

    constructor(file: MultipartFile) {
        id = ID22.random()
        time = Date()
        size = file.size
        name = file.originalFilename
        mimeType = file.contentType
        type = from(file).ordinal
    }
}
