package ${packagename}.util;

/**
 * 内存缓存工具 不存在自动添加缓存
 * Created by Administrator on 2015/10/27.
 */
public class SynchronizedLock<T> extends LruCache<T, T> {
    /**
     * @param maxSize for caches that do not override {@link #sizeOf}, this is
     *                the maximum number of entries in the cache. For all other caches,
     *                this is the maximum sum of the sizes of the entries in this cache.
     */
    public SynchronizedLock(int maxSize) {
        super(maxSize);
    }


    public synchronized T getLock(T key) {
        T value = super.get(key);
        if (value == null) {
            value = key;
            super.put(key, value);
        }
        return value;
    }
}
