package ${packageName}.shiro.model;

/**
 * Jwt 凭证持有者信息
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public class JwtBearer {

    public final ${loginTable.idColumn.fieldType} userId;
<#if loginTable.hasOrgan>
    <#assign orgFieldType=orgColumn.fieldType/>
    <#if loginTable.orgColumn.nullable>
        <#assign orgFieldType=orgColumn.fieldTypeObject/>
    </#if>
    public final ${orgFieldType} ${loginTable.orgColumn.fieldName};

    public JwtBearer(${loginTable.idColumn.fieldType} userId, ${orgFieldType} ${loginTable.orgColumn.fieldName}) {
        this.userId = userId;
        this.${loginTable.orgColumn.fieldName} = ${loginTable.orgColumn.fieldName};
    }
<#else >

    public JwtBearer(${loginTable.idColumn.fieldType} userId) {
        this.userId = userId;
    }
</#if>

}
