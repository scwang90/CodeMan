package ${packageName}.model.api

import com.github.pagehelper.PageRowBounds
import io.swagger.annotations.ApiModelProperty
import org.apache.ibatis.session.RowBounds

/**
 * @apiNote 数据分页列表信息
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
class Paging {

    @ApiModelProperty(value = "分页开始", notes = "0开始，如果使用 page 可不传", example = "0")
    var skip = 0
    @ApiModelProperty(value = "分页页码", notes = "0开始，如果使用 skip 可不传", example = "0")
    var page = 0
    @ApiModelProperty(value = "分页大小", notes = "配合 page 或 skip 组合使用", example = "20", required = true)
    var size = 100

    val count: Int
    get() {
        return size
    }

    val start: Int
    get() {
        return if (page > 0) size * (page - 1) else skip
    }

    val index: Int
    get() {
        return if (page > 0) page else skip / size
    }

    fun toRowBounds(): RowBounds {
        return PageRowBounds(start, size)
    }
}