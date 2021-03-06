package ${packageName}.model.api;

import ${packageName}.constant.UploadType;
import ${packageName}.util.ID22;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;


/**
 * 文件上传实体
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Data
@ApiModel(description = "上传文件")
public class Upload {

    @ApiModelProperty("文件类型")
    private int type = 0;
    @ApiModelProperty("文件大小")
    private long size = 0;
    @ApiModelProperty("文件 Id")
    private String id = null;
    @ApiModelProperty("文件名称")
    private String name = null;
    @ApiModelProperty("存储路径")
    private String path = null;
    @ApiModelProperty("媒体类型")
    private String mimeType = null;
    @ApiModelProperty("上传日期时间")
    private Date time = null;

    public Upload() {
    }

    public Upload(int type) {
        this.setType(type);
        this.setTime(new Date());
        this.setId(ID22.random());
    }

    public Upload(MultipartFile file) {
        this.setId(ID22.random());
        this.setTime(new Date());
        this.setSize(file.getSize());
        this.setName(file.getOriginalFilename());
        this.setMimeType(file.getContentType());
        this.setType(UploadType.from(file).ordinal());
    }

}
