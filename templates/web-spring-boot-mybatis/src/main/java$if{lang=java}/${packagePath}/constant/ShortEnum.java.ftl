package ${packageName}.constant;

/**
 * 枚举与短整型适配
 *
 * 由代码生成器生成，可以修改
 * 但是如果删除，下次继续生成时，又会出现
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public interface ShortEnum {

    default short origin() {
        if (this instanceof Enum) {
            return (short) ((Enum<?>) this).ordinal();
        }
        return 0;
    }
}
