package ${packageName}.model.api

import java.util.*

/**
 * @apiNote 数据分页列表信息
 * @author ${author}
 * @since ${.now?string("yyyy-MM-dd zzzz")}
 */
class Paged<T> {

    var pageSize = 0
    var currentPage = 0
    var totalPage = 0
    var totalRecord = 0

    var list: List<T> = ArrayList()

    constructor()

    constructor(paging: Paging, list: List<T>, count: Int) {
        this.list = list
        this.pageSize = paging.count()
        this.currentPage = paging.index()
        this.totalRecord = if (list.size > count ) list.size else count
        this.totalPage = this.totalRecord / this.pageSize
        if (this.totalRecord % this.pageSize > 0) {
            this.totalPage++
        }
    }


}
