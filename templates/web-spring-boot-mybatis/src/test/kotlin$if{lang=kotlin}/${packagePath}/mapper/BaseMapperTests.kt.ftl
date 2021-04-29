package ${packageName}.mapper

import com.fasterxml.jackson.databind.ObjectMapper
import ${packageName}.${projectName?cap_first}ApplicationTests

import org.junit.jupiter.api.Disabled

/**
 * 单元测试基类 - Mapper
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Disabled
class BaseMapperTests<T> : ${projectName?cap_first}ApplicationTests() {

    protected val json: ObjectMapper = ObjectMapper()

    protected val strInsert: String = "\$TEST\$"
    protected val strUpdate: String = "\$SET\$"

    protected fun buildInsertString(index: Int, max: Int): String {
        val length = strInsert.length
        if (length >= max) {
            return strInsert.substring(0, max)
        }
        return strInsert + index
    }
}
