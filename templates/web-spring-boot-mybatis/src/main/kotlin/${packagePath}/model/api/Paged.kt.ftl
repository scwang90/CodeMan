package ${packageName}.model.api

import java.util.*

/**
 * @apiNote 数据分页列表信息
 * @param <T> 数据实体类
 * @author 树朾
 * @since 2018-10-16 09:26:47 中国标准时间
</T> */
class Paged<T> {

    var pageSize = 0
    var currentPage = 0
    var totalPage = 0
    var totalRecord = 0

    var datas: List<T> = ArrayList()

    constructor()

    constructor(currentPage: Int, pageSize: Int, totalPage: Int, totalRecord: Int,
                datas: List<T>) : super() {
        this.currentPage = currentPage
        this.pageSize = pageSize
        this.totalPage = totalPage
        this.totalRecord = totalRecord
        this.datas = datas
    }

    constructor(all: List<T>) : super() {
        this.currentPage = 0
        this.pageSize = all.size
        this.totalPage = 1
        this.totalRecord = all.size
        this.datas = all
    }

    constructor(paging: Paging, list: List<T>, count: Int) {
        this.datas = list
        this.pageSize = paging.count()
        this.currentPage = paging.index()
        this.totalRecord = if (list.size > count ) list.size else count
        this.totalPage = this.totalRecord / this.pageSize
        if (this.totalRecord % this.pageSize > 0) {
            this.totalPage++
        }
    }


}
