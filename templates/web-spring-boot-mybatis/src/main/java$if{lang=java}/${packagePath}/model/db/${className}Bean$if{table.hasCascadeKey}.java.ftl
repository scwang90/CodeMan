package ${packageName}.model.db;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

<#if table.hasExportCascadeKey || table.hasRelatedCascadeKey>
import java.util.List;
</#if>

/**
 * ${table.remark} (包含外键数据)
<#list table.descriptions as description>
 * ${description}
</#list>
 *
 * 由代码生成器生成，不要修改
 * 当数据库有更新，使用生成器再次生成时，会覆盖所有修改
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Data
@EqualsAndHashCode(callSuper = true)
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
	private List<${key.fkTable.className}> ${tools.makeOneManyFiled(key)};
</#list>
<#list table.relateCascadeKeys as key>

	/*
	 * 关联${key.targetTable.remarkName}列表
	 */
	@ApiModelProperty(value = "${key.targetTable.remarkName}列表", notes = "通过${key.relateTable.remarkName}表多对多关联")
	private List<${key.targetTable.className}> related${tools.toPlural(key.targetTable.className)};
</#list>
<#list table.importCascadeKeys as key>

	//public ${key.pkTable.className} get${tools.idToModel(key.fkColumn.fieldNameUpper)}() {
	//	return this.${tools.idToModel(key.fkColumn.fieldName)};
	//}

	//public void set${tools.idToModel(key.fkColumn.fieldNameUpper)}(${key.pkTable.className} ${tools.idToModel(key.fkColumn.fieldName)}) {
	//	this.${tools.idToModel(key.fkColumn.fieldName)} = ${tools.idToModel(key.fkColumn.fieldName)};
	//}
</#list>
<#list table.exportCascadeKeys as key>

	//public List<${key.fkTable.className}> get${tools.makeOneManyFiled(key)?cap_first}() {
	//	return this.${tools.makeOneManyFiled(key)};
	//}

	//public void set${tools.makeOneManyFiled(key)?cap_first}(List<${key.fkTable.className}> ${tools.makeOneManyFiled(key)}) {
	//	this.${tools.makeOneManyFiled(key)} = ${tools.makeOneManyFiled(key)};
	//}
</#list>
<#list table.relateCascadeKeys as key>

	//public List<${key.targetTable.className}> get${tools.toPlural(key.targetTable.className)}() {
	//	return this.related${tools.toPlural(key.targetTable.className)};
	//}

	//public void set${tools.toPlural(key.targetTable.className)}(List<${key.targetTable.className}> ${tools.toPlural(key.targetTable.classNameCamel)}) {
	//	this.related${tools.toPlural(key.targetTable.className)} = ${tools.toPlural(key.targetTable.classNameCamel)};
	//}
</#list>
}