package ${packageName}.util;

import java.util.HashMap;
import java.util.Map;

/**
 * Mapper 通用 Where 字典，包含 And 和 Or
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public class WhereMap {

    Map<String, Object> andMap;
    Map<String, Object> orMap;

    public static WhereMap New() {
        WhereMap map = new WhereMap();
        map.andMap = new HashMap<>();
        map.orMap = new HashMap<>();
        return map;
    }

    public WhereMap and(String key,String val){
        this.andMap.put(key,val);
        return this;
    }

    public WhereMap or(String key,String val){
        this.orMap.put(key,val);
        return this;
    }

    public Map<String, Object> getAndMap() {
        return andMap;
    }

    public Map<String, Object> getOrMap() {
        return orMap;
    }
}
