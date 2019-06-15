package ${packageName}.model.api

/**
 * @apiNote 数据分页列表信息
 * @author ${author}
 * @since ${.now?string("yyyy-MM-dd HH:mm:ss zzzz")}
 */
data class Paging (
        var skip: Int = 0,
        var page: Int = 0,
        var size: Int = Int.MAX_VALUE
){
    fun count(): Int { return size }
    fun start(): Int { return if (page > 0) size * page else skip }
    fun index(): Int { return if (page > 0) page else skip / size }
}