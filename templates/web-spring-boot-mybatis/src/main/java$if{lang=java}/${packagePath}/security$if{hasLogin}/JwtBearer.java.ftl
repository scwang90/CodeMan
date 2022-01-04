package ${packageName}.security;

/**
 * Jwt 凭证持有者信息
 *
 * 由代码生成器生成，可以修改
 * 但是如果删除，下次继续生成时，又会出现
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public class JwtBearer {

    public final String type;
    public final ${loginTable.idColumn.fieldType} userId;
<#if loginTable.hasOrgan>
    <#assign orgFieldType=orgColumn.fieldType/>
    <#if loginTable.orgColumn.nullable>
        <#assign orgFieldType=orgColumn.fieldTypeObject/>
    </#if>
    public final ${orgFieldType} ${loginTable.orgColumn.fieldName};

    public JwtBearer(String type, ${loginTable.idColumn.fieldType} userId, ${orgFieldType} ${loginTable.orgColumn.fieldName}) {
        this.type = type;
        this.userId = userId;
        this.${loginTable.orgColumn.fieldName} = ${loginTable.orgColumn.fieldName};
    }
<#else >

    public JwtBearer(String type, ${loginTable.idColumn.fieldType} userId) {
        this.type = type;
        this.userId = userId;
    }
</#if>
}
