package ${packageName}.mapper.intent.impl

import ${packageName}.mapper.intent.api.OrderQuery
import ${packageName}.mapper.intent.api.WhereQuery
import kotlin.math.max

open class QueryWhere<T> : WhereItem<T> , WhereQuery<T> {

    private var level = 0

    private var _wheres: MutableList<WhereQuery<T>>? = null

    override val wheres: List<WhereQuery<T>>?
        get() { 
            return _wheres 
        }

    private val isMultCondition: Boolean
        get() {
            return _wheres != null
        }

    constructor(where: WhereQuery<T>) {
        if (where is QueryWhere<T>) {
            this.op = where.op
            this.column = where.column
            this.value = where.value
            this.level = where.level
            this._wheres = where._wheres
        }
    }

    constructor(where: QueryWhere<T>): super(where = where) {
        this.level = where.level
        this._wheres = where._wheres
    }
    
    constructor(column: String, op: String, value: Any?) {
        this.op = op
        this.value = value
        this.column = column
    }
    
    constructor(left: QueryWhere<T>, op: String, right: QueryWhere<T>) {
        this.op = op
        this.level = max(left.level, right.level) + 1
        this._wheres = mutableListOf(left, right)
        this.checkLevel()
    }

    private fun merge(op: String, right: QueryWhere<T>): QueryWhere<T> {
        if (isMultCondition != right.isMultCondition) {
            return if (isMultCondition) {
                annex(right, op)
            } else {
                right.annex(this, op)
            }
        } else if (isMultCondition && right.isMultCondition) {
            return when (op) {
                this.op -> {
                    annex(right, op)
                }
                right.op -> {
                    right.annex(this, op)
                }
                else -> {
                    newCondition(op, right)
                }
            }
        }
        return newCondition(op, right)
    }

    private fun newCondition(op: String, right: QueryWhere<T>): QueryWhere<T> {
        return QueryWhere(this, op, right)
    }

    /**
     * 吞并条件 where
     */
    private fun annex(where: QueryWhere<T>, op: String): QueryWhere<T> {
        val wheres = this._wheres ?: throw RuntimeException("annex(Condition,op)函数中，叶级别无法吞并！")
        return if (op == this.op) {
            if (where._wheres != null && op == where.op) {
                if (level < where.level) {
                    level = where.level + 1
                }
                where._wheres?.let {
                    wheres.addAll(it)
                }
            } else {
                if (level <= where.level) {
                    level = where.level + 1
                }
                wheres.add(where)
            }
            checkLevel()
            this
        } else {
            newCondition(op, where)
        }
    }

    private fun checkLevel() {
        if (level > 3) {
            throw RuntimeException("checkLevel() = $level, 不能超过2！")
        }
    }

    //<editor-fold desc="实现接口">
    override fun or(where: WhereQuery<T>): QueryWhere<T> {
        if (where is QueryWhere<T> ) {
            return merge("OR", where)
        }
        return this
    }

    override fun and(where: WhereQuery<T>): QueryWhere<T> {
        if (where is QueryWhere<T> ) {
            return merge("AND", where)
        }
        return this
    }

    override fun orderBy(vararg orders: OrderQuery<T>): OrderQuery<T> {
        return OrderWhere<T>(this).orderBy(*orders)
    }
    //</editor-fold>

}