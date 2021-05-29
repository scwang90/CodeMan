package ${packageName}.model.api

import com.github.pagehelper.Page
import kotlin.math.max

/**
 * @apiNote 数据分页列表信息
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Suppress("MemberVisibilityCanBePrivate")
class Paged<T> {

    var pageSize = 0
    var currentPage = 0
    var totalPage = 0
    var totalRecord = 0
    var list: List<T> = ArrayList()

    constructor()

    constructor(paging: Paging, list: List<T>) {
        this.list = list
        pageSize = paging.count
        currentPage = paging.index
        if (list is Page<*>) {
            totalRecord = max(list.size, (list as Page<*>).total.toInt())
            totalPage = totalRecord / pageSize
            if (totalRecord % pageSize > 0) {
                totalPage++
            }
        }
    }

    constructor(paging: Paging, list: List<T>, count: Int) {
        this.list = list
        pageSize = paging.count
        currentPage = paging.index
        totalRecord = max(list.size, count)
        totalPage = totalRecord / pageSize
        if (totalRecord % pageSize > 0) {
            totalPage++
        }
    }

}
