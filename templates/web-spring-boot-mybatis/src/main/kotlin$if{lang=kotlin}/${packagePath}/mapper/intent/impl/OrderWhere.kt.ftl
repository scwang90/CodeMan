package ${packageName}.mapper.intent.impl

import ${packageName}.mapper.intent.api.OrderQuery
import ${packageName}.mapper.intent.api.WhereQuery

class OrderWhere<T>(where: QueryWhere<T>) : WhereItem<T>(where), OrderQuery<T> {

    private val _orders = mutableListOf<OrderQuery<T>>()
    private val _wheres: List<WhereQuery<T>>? = where.wheres

    override val wheres: List<WhereQuery<T>>?
        get() { return _wheres }
    override val orders: List<OrderQuery<T>>
        get() { return _orders }

    override fun orderBy(vararg orders: OrderQuery<T>): OrderQuery<T> {
        _orders.addAll(orders)
        return this
    }

}