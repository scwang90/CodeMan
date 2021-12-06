package ${packageName}.constant;

/**
 * 枚举与短整型适配
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
