package ${packageName}.model.api;

import ${packageName}.constant.UploadType;
import ${packageName}.util.ID22;

import org.springframework.web.multipart.MultipartFile;

import java.util.Date;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;


/**
 * 文件上传实体
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@ApiModel(description = "上传文件")
public class Upload {

    @ApiModelProperty("文件类型")
    private int type = 0;
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
        this.setName(file.getOriginalFilename());
        this.setMimeType(file.getContentType());
        this.setType(UploadType.from(file).ordinal());
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getMimeType() {
        return mimeType;
    }

    public void setMimeType(String mimeType) {
        this.mimeType = mimeType;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

}
