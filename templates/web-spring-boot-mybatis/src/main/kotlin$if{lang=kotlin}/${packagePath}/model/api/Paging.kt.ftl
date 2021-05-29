package ${packageName}.model.api

import com.github.pagehelper.PageRowBounds
import org.apache.ibatis.session.RowBounds

/**
 * @apiNote 数据分页列表信息
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
class Paging {
    var skip = 0
    var page = 0
    var size = Int.MAX_VALUE

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