package ${packageName}.constant;

/**
 * 用户类型
 *
 * 由代码生成器生成，可以修改
 * 但是如果删除，下次继续生成时，又会出现
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public enum UserType implements ShortEnum {
<#if hasMultiLogin>
    <#list loginTables as table>${table.className}<#if table_has_next>, </#if></#list>
<#else >
    Other, Admin, User
</#if>
}
