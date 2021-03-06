package ${packageName}.model.api;

import com.github.pagehelper.Page;

import java.util.ArrayList;
import java.util.List;

/**
 * @apiNote 数据分页列表信息
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@SuppressWarnings("WeakerAccess")
public class Paged<T> {

    public int pageSize = 0;
    public int currentPage = 0;
    public int totalPage = 0;
    public int totalRecord = 0;

    public List<T> list = new ArrayList<>();

    public Paged() {

    }

    public Paged(Paging paging, List<T> list) {
        this.list = list;
        this.pageSize = paging.count();
        this.currentPage = paging.index();

        if (list instanceof Page) {
            this.totalRecord = Math.max(list.size(), (int)((Page<?>) list).getTotal());
            this.totalPage = this.totalRecord / this.pageSize;
            if (this.totalRecord % this.pageSize > 0) {
                this.totalPage++;
            }
        }
    }

    public Paged(Paging paging, List<T> list, int count) {
        this.list = list;
        this.pageSize = paging.count();
        this.currentPage = paging.index();
        this.totalRecord = Math.max(list.size(), count);
        this.totalPage = this.totalRecord / this.pageSize;
        if (this.totalRecord % this.pageSize > 0) {
            this.totalPage++;
        }
    }

}