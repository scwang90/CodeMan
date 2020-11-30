package ${packageName}.util;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.HashSet;

/**
 * Mapper 通用 SQL 查询意图，包含 And 和 Or 和 Order
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public class SqlIntent {

    Set<String> orderSet;           // 排序查询
    Map<String, Object> setMap;     // Update
    Map<String, Object> andMap;     // 与条件
    Map<String, Object> orMap;      // 或条件

    public static SqlIntent New() {
        SqlIntent map = new SqlIntent();
        map.orMap = new HashMap<>();
        map.andMap = new HashMap<>();
        map.setMap = new HashMap<>();
        map.orderSet = new HashSet<>();
        return map;
    }

    public SqlIntent and(String key, String val){
        this.andMap.put(key,val);
        return this;
    }

    public SqlIntent or(String key, String val){
        this.orMap.put(key,val);
        return this;
    }

    public SqlIntent set(String key, String val){
        this.setMap.put(key,val);
        return this;
    }

    public SqlIntent order(String order){
        this.orderSet.add(order);
        return this;
    }

    public Set<String> getOrderSet() {
        return orderSet;
    }

    public Map<String, Object> getSetMap() {
        return setMap;
    }

    public Map<String, Object> getAndMap() {
        return andMap;
    }

    public Map<String, Object> getOrMap() {
        return orMap;
    }
}
