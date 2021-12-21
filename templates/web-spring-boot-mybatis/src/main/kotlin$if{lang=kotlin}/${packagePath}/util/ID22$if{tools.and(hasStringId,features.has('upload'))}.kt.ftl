package ${packageName}.util

import org.apache.tomcat.util.codec.binary.Base64

import java.util.UUID

/**
 * 22位ID
 * 用于生成22位长度的 UUID
 * 我们知道UUID的字符串值是32位的，在数据库中直接作为Id使用，很占空间。
 * 如果表结构简单，表关联外建过多，最终会出现这样的情况，100MB的数据库文件里面60MB以上都是UUID所占用的空间！
 * 所以在数据库ID的设计中，一般能节省空间则节省空间，可以采用Id自增的int类型，这是最节省空间的了。
 * 如果羡慕必须使用UUID，那我们还可以选折中方案来压缩UUID，UUID本质是 128 位的二进制位，
 * 代码中可以拿到 两个 long 值，UUID的值默认是使用 16进制来显示两个 long的需要32位字符串。
 * 本ID22，采用Base64的方案来显示UUID中的两个 long 值，只需要 22位字符串。
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
object ID22 {

    fun random(): String {
        return compressedUUID(UUID.randomUUID())
    }

    private fun compressedUUID(uuid: UUID): String {
        val byUuid = ByteArray(16)
        val least = uuid.leastSignificantBits
        val most = uuid.mostSignificantBits
        long2bytes(most, byUuid, 0)
        long2bytes(least, byUuid, 8)
        return Base64.encodeBase64URLSafeString(byUuid)
    }

    private fun long2bytes(value: Long, bytes: ByteArray, offset: Int) {
        var off = offset
        for (i in 7 downTo -1 + 1) {
            bytes[off++] = (value shr 8 * i and 0xFF).toByte()
        }
    }
}