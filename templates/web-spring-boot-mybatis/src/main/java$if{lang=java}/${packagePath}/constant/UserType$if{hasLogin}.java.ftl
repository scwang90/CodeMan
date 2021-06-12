package ${packageName}.constant;

/**
 * 用户类型
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public enum UserType implements ShortEnum {
<#if hasMultiLogin>
    <#list loginTables as table>${table.className}<#if table_has_next>, </#if></#list>
<#else >
    Admin, User
</#if>
}
