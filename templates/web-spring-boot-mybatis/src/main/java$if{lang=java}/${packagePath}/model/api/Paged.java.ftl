package ${packageName}.model.api;

import com.github.pagehelper.Page;

import java.util.ArrayList;
import java.util.List;

/**
 * 数据分页列表信息
 *
 * 由代码生成器生成，可以修改
 * 但是如果删除，下次继续生成时，又会出现
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@SuppressWarnings("WeakerAccess")
public class Paged<T> {

    public int size = 0;
    public int current = 0;
    public int total = 0;

    public List<T> list = new ArrayList<>();

    public Paged() {

    }

    public Paged(Paging paging, List<T> list) {
        this.list = list;
        this.size = paging.count();
        this.current = paging.index();

        if (list instanceof Page) {
            this.total = Math.max(list.size(), (int)((Page<?>) list).getTotal());
        }
    }

    public Paged(Paging paging, List<T> list, int count) {
        this.list = list;
        this.size = paging.count();
        this.current = paging.index();
        this.total = Math.max(list.size(), count);
    }

}