package ${packageName}.mapper;

import ${packageName}.${projectClassName}ApplicationTests;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Disabled;

/**
 * 单元测试基类 - Mapper
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Disabled
public class BaseMapperTests<T> extends ${projectClassName}ApplicationTests {

    protected final ObjectMapper json = new ObjectMapper();

    protected static final String strInsert = "$TEST$";
    protected static final String strUpdate = "$SET$";

    protected String buildInsertString(int index, int max) {
        int length = strInsert.length();
        if (length >= max) {
            return strInsert.substring(0, max);
        }
        return strInsert + index;
    }
}
