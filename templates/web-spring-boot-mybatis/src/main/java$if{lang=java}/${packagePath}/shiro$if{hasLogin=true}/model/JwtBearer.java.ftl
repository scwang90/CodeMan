package ${packageName}.shiro.model;

/**
 * Jwt 凭证持有者信息
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public class JwtBearer {

    public final ${loginTable.idColumn.fieldType} userId;
<#if orgColumn??>
    <#assign orgFieldType=orgColumn.fieldType/>
    <#if loginTable.orgColumn.nullable>
        <#assign orgFieldType=orgColumn.fieldTypeObject/>
    </#if>
    public final ${orgFieldType} ${orgColumn.fieldName};

    public JwtBearer(${loginTable.idColumn.fieldType} userId, ${orgFieldType} ${orgColumn.fieldName}) {
        this.userId = userId;
        this.${orgColumn.fieldName} = ${orgColumn.fieldName};
    }
<#else >

    public JwtBearer(${loginTable.idColumn.fieldType} userId) {
        this.userId = userId;
    }
</#if>

}
