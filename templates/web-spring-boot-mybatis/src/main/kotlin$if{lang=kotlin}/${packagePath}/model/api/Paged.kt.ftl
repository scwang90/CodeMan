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

    var size = 0
    var current = 0
    var total = 0
    var list: List<T> = ArrayList()

    constructor()

    constructor(paging: Paging, list: List<T>) {
        this.list = list
        size = paging.count
        current = paging.index
        if (list is Page<*>) {
            total = max(list.size, (list as Page<*>).total.toInt())
        }
    }

    constructor(paging: Paging, list: List<T>, count: Int) {
        this.list = list
        size = paging.count
        current = paging.index
        total = max(list.size, count)
    }

}
