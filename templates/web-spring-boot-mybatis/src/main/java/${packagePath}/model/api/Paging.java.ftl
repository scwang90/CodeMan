package ${packageName}.model.api;

/**
 * @apiNote 数据分页列表信息
 * @author ${author}
 * @since ${.now?string("yyyy-MM-dd zzzz")}
 */
public class Paging {

    public int skip = 0;
    public int page = 0;
    public int size = Integer.MAX_VALUE;

    public int count() { return size; }
    public int start() { return (page > 0) ? size * page : skip; }
    public int index() { return (page > 0) ? page : skip / size; }

    public void setPage(int page) {
        this.page = page;
    }

    public void setSize(int size) {
        this.size = size;
    }

    public void setSkip(int skip) {
        this.skip = skip;
    }
}
