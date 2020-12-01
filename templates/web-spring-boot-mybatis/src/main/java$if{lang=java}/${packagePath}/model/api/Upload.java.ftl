package ${packageName}.model.api;

import ${packageName}.constant.UploadType;
import ${packageName}.util.ID22;

import org.springframework.web.multipart.MultipartFile;

import java.util.Date;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;


/**
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@ApiModel(description = "上传文件")
public class Upload {

    @ApiModelProperty("文件类型")
    public int type = 0;
    @ApiModelProperty("文件 Id-Token")
    public String token = null;
    @ApiModelProperty("文件名称")
    public String name = null;
    @ApiModelProperty("存储路径")
    public String path = null;
    @ApiModelProperty("媒体类型")
    public String mimeType = null;
    @ApiModelProperty("上传日期时间")
    public Date time = null;

    public Upload() {
    }

    public Upload(int type) {
        this.type = type;
        this.time = new Date();
        this.token = ID22.random();
    }

    public Upload(MultipartFile file) {
        this.time = new Date();
        this.token = ID22.random();
        this.mimeType = file.getContentType();
        this.name = file.getOriginalFilename();
        this.type = UploadType.from(file).ordinal();
    }

}
