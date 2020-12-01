package ${packageName}.util

import org.apache.tomcat.util.codec.binary.Base64

import java.util.UUID

class ID22 private constructor() {

    private val id22: String

    init {
        id22 = compressedUUID(UUID.randomUUID())
    }

    companion object {

        fun random(): String {
            return ID22().id22
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
            var index = offset
            for (i in 7 downTo -1 + 1) {
                bytes[index++] = (value shr 8 * i and 0xFF).toByte()
            }
        }
    }
}