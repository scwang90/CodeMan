package ${packageName}.mapper;

import com.fasterxml.jackson.databind.ObjectMapper;
import ${packageName}.model.Entity;
import ${packageName}.${projectName?cap_first}ApplicationTests;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * 单元测试基类 - Mapper
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public class BaseMapperTests<T extends Entity> extends ${projectName?cap_first}ApplicationTests {

    @Autowired
    protected TypedMapper<T> mapper;

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
