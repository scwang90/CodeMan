package ${packageName}.mapper;

/**
 * Hash 持久化存储错误信息Mapper
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public interface HashErrorMapper {

    /**
     * 持久化错误信息
     * @param e 错误信息
     * @return 返回错误的 HASH
     */
    String persistException(Throwable e);

    /**
     * 持久化错误信息
     * @param e 错误信息
     * @param remark 备注信息
     * @return 返回错误的 HASH
     */
    String persistException(Throwable e, String remark);

}
