/*  This class is generated by CodeMan */package ${packageName}.mapper.intent.tables;import ${packageName}.mapper.intent.impl.TableField;import ${packageName}.mapper.intent.impl.TableImpl;public class ${table.classNameUpper} extends TableImpl {    private final String name;    public ${table.classNameUpper}(String name) {        this.name = name;    }    public String getName() {        return name;    }    /**     * The reference instance of <code>${className}</code>     */    public static final ${table.classNameUpper} TABLE = new ${table.classNameUpper}("${table.nameSqlInStr}");    <#list table.columns as column>    /**     * The column <code>${className}.${column.fieldName}</code>.     */    public final TableField<${table.classNameUpper}, ${column.fieldTypeObject}> ${column.fieldNameUpper} = new TableField<>("${column.name}");    </#list>}