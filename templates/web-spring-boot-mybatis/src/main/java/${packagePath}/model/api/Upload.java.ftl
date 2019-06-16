package ${packageName}.model.api;

import java.util.Date;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

/**
 * @author ${author}
 * @since ${.now?string("yyyy-MM-dd HH:mm:ss zzzz")}
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
    @ApiModelProperty("上传日期时间")
    public Date time = null;

}
