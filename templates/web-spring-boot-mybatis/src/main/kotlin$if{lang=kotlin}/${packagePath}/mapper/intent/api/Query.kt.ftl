package ${packageName}.mapper.intent.apiinterface Query<T> {    val wheres: List<WhereQuery<T>>?        get() { return null}    val orders: List<OrderQuery<T>>?        get() { return null}    val masterTable: String        get() { return "" }    val defaultOrder: String        get() { return "" }}