package ${packageName}.util

import java.util.*

/**
 * 雪花算法工具类
 *
 * SnowFlake可以保证：
 * 所有生成的id按时间趋势递增，
 * 整个分布式系统内不会产生重复id（因为有datacenterId和workerId来做区分）！
 *
 * SnowFlake算法的优点：
 * （1）高性能高可用：生成时不依赖于数据库，完全在内存中生成。
 *
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
object SnowUtil {

    private val instance: Snowflake = Snowflake(1,1)

    fun nextId(): Long {
        return instance.nextId()
    }

    class Snowflake(epochDate: Date?, private val workerId: Long, private val dataCenterId: Long) {

        private var twepoch: Long = 0
        private var sequence = 0L
        private var lastTimestamp: Long

        constructor(workerId: Long, dataCenterId: Long) : this(null, workerId, dataCenterId)

        init {
            lastTimestamp = -1L
            twepoch = epochDate?.time ?: 1288834974657L

            if (workerId in 0L..31L) {
                if (dataCenterId !in 0L..31L) {
                    throw IllegalArgumentException("datacenter Id can't be greater than 31L or less than 0")
                }
            } else {
                throw IllegalArgumentException("worker Id can't be greater than 31L or less than 0")
            }
        }

        fun getWorkerId(id: Long): Long {
            return id shr 12 and 31L
        }

        fun getDataCenterId(id: Long): Long {
            return id shr 17 and 31L
        }

        fun getGenerateDateTime(id: Long): Long {
            return (id shr 22 and 2199023255551L) + twepoch
        }

        @Synchronized
        fun nextId(): Long {
            var timestamp = genTime()
            if (timestamp < lastTimestamp) {
                check(lastTimestamp - timestamp < 2000L) {
                    "Clock moved backwards. Refusing to generate id for ${r"$"}{lastTimestamp - timestamp}ms"
                }
                timestamp = lastTimestamp
            }
            if (timestamp == lastTimestamp) {
                val sequence = sequence + 1L and 4095L
                if (sequence == 0L) {
                    timestamp = tilNextMillis(lastTimestamp)
                }
                this.sequence = sequence
            } else {
                sequence = 0L
            }
            lastTimestamp = timestamp
            return timestamp - twepoch shl 22 or (dataCenterId shl 17) or (workerId shl 12) or sequence
        }

        fun nextIdStr(): String {
            return nextId().toString()
        }

        private fun tilNextMillis(lastTimestamp: Long): Long {
            var timestamp: Long
            timestamp = genTime()
            while (timestamp == lastTimestamp) {
                timestamp = genTime()
            }
            if (timestamp < lastTimestamp) {
                throw IllegalStateException("Clock moved backwards. Refusing to generate id for ${r"$"}{lastTimestamp - timestamp}ms")
            }
            return timestamp
        }

        private fun genTime(): Long {
            return System.currentTimeMillis()
        }
    }


}