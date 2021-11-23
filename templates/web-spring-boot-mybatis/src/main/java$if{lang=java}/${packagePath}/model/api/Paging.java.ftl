package ${packageName}.model.api;

import com.github.pagehelper.PageRowBounds;
import io.swagger.annotations.ApiModelProperty;
import org.apache.ibatis.session.RowBounds;

/**
 * @apiNote 数据分页列表信息
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public class Paging {

    @ApiModelProperty(value = "分页开始", notes = "0开始，如果使用 page 可不传", example = "0")
    public int skip = 0;
    @ApiModelProperty(value = "分页页码", notes = "0开始，如果使用 skip 可不传", example = "0")
    public int page = 0;
    @ApiModelProperty(value = "分页大小", notes = "配合 page 或 skip 组合使用", example = "20", required = true)
    public int size = 100;

    public int count() { return size; }
    public int start() { return (page > 0) ? size * page : skip; }
    public int index() { return (page > 0) ? page : skip / size; }

    public void setPage(int page) {
        this.page = page;
    }

    public void setSize(int size) {
        this.size = size;
    }

    public void setSkip(int skip) {
        this.skip = skip;
    }

    public RowBounds toRowBounds() {
        return new PageRowBounds(start(), size);
    }
}
