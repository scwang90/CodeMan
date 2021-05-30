package ${packageName}.mapper

import org.apache.ibatis.annotations.Mapper
import org.apache.ibatis.annotations.Param
import org.apache.ibatis.annotations.Select

/**
 * 通用 的 mapper 接口
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Mapper
interface CommonMapper {

	/**
	 * 统计某表中的编码的最大值
	 * @param table 表名
	 * @return 最大编号
	 */
	@Select("SELECT COALESCE(MAX(${codeColumn.nameSqlInStr}),'0') FROM \${r"$"}{table}")
	fun maxCodeByTable(@Param("table") table: String): Int

<#if hasOrgan>
	/**
	 * 统计某${organTable.remarkName}某表中的编码的最大值
	 * @param table 表名
	 * @param ${orgColumn.fieldName} ${organTable.remarkName}Id
	 * @return 最大编号
	 */
	@Select("SELECT COALESCE(MAX(code),'0') FROM \${r"$"}{table} WHERE ${orgColumn.nameSqlInStr} = ${r"#"}{${orgColumn.fieldName}}")
	fun maxCodeByTableAndOrg(@Param("table") table: String, @Param("${orgColumn.fieldName}") ${orgColumn.fieldName}: ${orgColumn.fieldTypeObject}): Int
</#if>

}
