package ${packageName}.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

/**
 * 通用 的 mapper 接口
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Mapper
public interface CommonMapper {

	/**
	 * 统计某表中的编码的最大值
	 * @param table 表名
	 * @return 最大编号
	 */
	@Select("SELECT COALESCE(MAX(${codeColumn.nameSqlInStr}),'0') FROM ${r"$"}{table}")
	int maxCodeByTable(@Param("table") String table);

<#if hasOrg>
	/**
	 * 统计某机构某表中的编码的最大值
	 * @param table 表名
	 * @param ${orgColumn.fieldName} 机构Id
	 * @return 最大编号
	 */
	@Select("SELECT COALESCE(MAX(code),'0') FROM ${r"$"}{table} WHERE ${orgColumn.nameSqlInStr} = ${r"#"}{${orgColumn.fieldName}}")
	int maxCodeByTableAndOrg(@Param("table") String table, @Param("${orgColumn.fieldName}") ${orgColumn.fieldTypeObject} ${orgColumn.fieldName});
</#if>

}