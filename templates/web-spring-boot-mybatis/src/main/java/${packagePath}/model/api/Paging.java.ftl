package ${packageName}.model.api;

/**
 * @apiNote 数据分页列表信息
 * @author ${author}
 * @since ${.now?string("yyyy-MM-dd HH:mm:ss zzzz")}
 */
public class Paging {

    public int skip = 0;
    public int page = 0;
    public int size = Integer.MAX_VALUE;

    public int count() { return size; }
    public int start() { return (page > 0) ? size * page : skip; }
    public int index() { return (page > 0) ? page : skip / size; }

}
