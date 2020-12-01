package ${packageName}.util;

import ${packageName}.exception.ServiceException;

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

    public SqlIntent where(String key, Object val) {
        if (!this.whereMap.isEmpty()) {
            throw new ServiceException("where 方法只能最开始调用一次");
        }
        this.whereMap.put(key,val);
        return this;
    }

    public SqlIntent and(String key, Object val){
        if (this.whereMap.isEmpty()) {
            throw new ServiceException("条件查询请先调用 where 方法");
        } else if (this.andMap.isEmpty() && this.orMap.isEmpty()) {
            this.andMap.putAll(this.whereMap);
        }
        this.andMap.put(key,val);
        return this;
    }

    public SqlIntent or(String key, Object val){
        if (this.whereMap.isEmpty()) {
            throw new ServiceException("条件查询请先调用 where 方法");
        } else if (this.orMap.isEmpty() && this.andMap.isEmpty()) {
            this.orMap.putAll(this.whereMap);
        }
        this.orMap.put(key,val);
        return this;
    }

    public SqlIntent set(String key, Object val){
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
        if (!this.whereMap.isEmpty() && this.orMap.isEmpty() && this.andMap.isEmpty()) {
            this.andMap.putAll(this.whereMap);
        }
        return andMap;
    }

    public Map<String, Object> getOrMap() {
        if (!this.whereMap.isEmpty() && this.orMap.isEmpty() && this.andMap.isEmpty()) {
            this.orMap.putAll(this.whereMap);
        }
        return orMap;
    }
}
