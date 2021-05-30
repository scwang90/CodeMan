package ${packageName}.model.db;

import io.swagger.annotations.ApiModelProperty;

import java.util.List;

/**
 * ${table.remark} (包含外键数据)
<#list table.descriptions as description>
 * ${description}
</#list>
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public class ${className}Bean extends ${className} {
<#list table.importCascadeKeys as key>

	/*
	 * 关联${key.pkTable.remarkName}
	 */
	@ApiModelProperty(value = "关联${key.fkTable.remarkName}", notes = "一对一关联")
	private ${key.pkTable.className} ${tools.idToModel(key.fkColumn.fieldName)};
</#list>
<#list table.exportCascadeKeys as key>

	/*
	 * ${key.fkTable.remarkName}列表
	 */
	@ApiModelProperty(value = "${key.fkTable.remarkName}列表", notes = "一对多关联")
	private List<${key.fkTable.className}> ${tools.toPlural(key.fkTable.classNameCamel)};
</#list>
<#list table.relateCascadeKeys as key>

	/*
	 * 关联${key.targetTable.remarkName}列表
	 */
	@ApiModelProperty(value = "${key.targetTable.remarkName}列表", notes = "通过${key.relateTable.remarkName}表多对多关联")
	private List<${key.targetTable.className}> related${tools.toPlural(key.targetTable.className)};
</#list>
<#list table.importCascadeKeys as key>

	public ${key.pkTable.className} get${tools.idToModel(key.fkColumn.fieldNameUpper)}() {
		return this.${tools.idToModel(key.fkColumn.fieldName)};
	}

	public void set${tools.idToModel(key.fkColumn.fieldNameUpper)}(${key.pkTable.className} ${tools.idToModel(key.fkColumn.fieldName)}) {
		this.${tools.idToModel(key.fkColumn.fieldName)} = ${tools.idToModel(key.fkColumn.fieldName)};
	}
</#list>
<#list table.exportCascadeKeys as key>

	public List<${key.fkTable.className}> get${tools.toPlural(key.fkTable.className)}() {
		return this.${tools.toPlural(key.fkTable.classNameCamel)};
	}

	public void set${tools.toPlural(key.fkTable.className)}(List<${key.fkTable.className}> ${tools.toPlural(key.fkTable.classNameCamel)}) {
		this.${tools.toPlural(key.fkTable.classNameCamel)} = ${tools.toPlural(key.fkTable.classNameCamel)};
	}
</#list>
<#list table.relateCascadeKeys as key>

	public List<${key.targetTable.className}> get${tools.toPlural(key.targetTable.className)}() {
		return this.related${tools.toPlural(key.targetTable.className)};
	}

	public void set${tools.toPlural(key.targetTable.className)}(List<${key.targetTable.className}> ${tools.toPlural(key.targetTable.classNameCamel)}) {
		this.related${tools.toPlural(key.targetTable.className)} = ${tools.toPlural(key.targetTable.classNameCamel)};
	}
</#list>
}