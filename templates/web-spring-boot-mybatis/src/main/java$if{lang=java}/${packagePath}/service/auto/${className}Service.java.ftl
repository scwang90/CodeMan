package ${packageName}.service.auto;
<#assign hasSearch=false/>
<#list table.columns as column>
	<#if column.name?lower_case?contains('name') || column.name?lower_case?contains('title') >
		<#assign searchColumn=column/>
		<#assign hasSearch=true/>
		<#break />
	</#if>
</#list>

<#if table.hasOrgan || table == loginTable>
import ${packageName}.exception.ClientException;
</#if>
<#if hasSearch>
import com.github.pagehelper.util.StringUtil;
</#if>
<#if table == organTable && hasLogin>
import com.traveler.server.exception.AccessException;
</#if>
<#if table.hasCode>
import ${packageName}.mapper.CommonMapper;
</#if>
import ${packageName}.mapper.intent.Tables;
import ${packageName}.mapper.auto.${className}Mapper;
import ${packageName}.mapper.intent.api.WhereQuery;
import ${packageName}.model.api.Paged;
import ${packageName}.model.api.Paging;
import ${packageName}.model.db.${className};
<#if table.hasCode>
import ${packageName}.util.CommonUtil;
</#if>
<#if !table.idColumn.autoIncrement && table.idColumn.stringType>
import ${packageName}.util.ID22;
</#if>
<#if table.hasOrgan || table == loginTable || (table == organTable  && hasLogin) || (hasLogin && table.hasCreator)>
import ${packageName}.util.JwtUtils;
</#if>

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

<#if table.hasRemove>
import java.util.Arrays;
</#if>
import java.util.List;
<#if table.hasRemove && table.idColumn.intType>
import java.util.stream.Collectors;
</#if>


/**
 * ${table.remark} 的 Service 层实现
<#list table.descriptions as description>
 * ${description}
</#list>
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@AllArgsConstructor
@Service("auto${className}Service")
public class ${className}Service {

<#if table.hasCode>
	private final CommonMapper commonMapper;
</#if>
	private final ${className}Mapper mapper;

	/**
	 * ${table.remarkName}列表
	 * @param paging 分页对象
<#if hasSearch>
	 * @param key 搜索关键字
</#if>
	 */
    public Paged<${className}> list(Paging paging<#if hasSearch>, String key</#if>) {
<#if table.hasOrgan>
		${table.orgColumn.fieldTypeObject} ${table.orgColumn.fieldName} = JwtUtils.currentBearer().${table.orgColumn.fieldName};
		WhereQuery<${className}> where = Tables.${table.className}.${table.orgColumn.fieldNameUpper}.eq(${table.orgColumn.fieldName});
<#else>
		WhereQuery<${className}> where = Tables.${table.className}.where();
</#if>
<#if table.hasRemove>
	<#if table.removeColumn.boolType>
		where = where.and(Tables.${className}.${table.removeColumn.fieldNameUpper}.isNull().or(Tables.${className}.${table.removeColumn.fieldNameUpper}.eq(Boolean.FALSE)));
	<#elseif table.removeColumn.intType>
		where = where.and(Tables.${className}.${table.removeColumn.fieldNameUpper}.isNull().or(Tables.${className}.${table.removeColumn.fieldNameUpper}.eq(0)));
	<#else>
		where = where.and(Tables.${className}.${table.removeColumn.fieldNameUpper}.isNull().or(Tables.${className}.${table.removeColumn.fieldNameUpper}.ne("removed")));
	</#if>
</#if>
	<#if hasSearch>
		if (StringUtil.isNotEmpty(key)) {
			where = where.and(Tables.${table.className}.${searchColumn.fieldNameUpper}.contains(key));
		}
	</#if>
		List<${className}> list = mapper.selectWhere(where, paging.toRowBounds());
		return new Paged<>(paging, list);
    }

	/**
	 * 添加${table.remarkName}
	 * @param model 实体对象
	 × @return 返回新数据的Id
	 */
	public ${table.idColumn.fieldType} insert(${className} model) {
<#if table.hasId && !table.idColumn.autoIncrement && table.idColumn.stringType>
		if(model.get${table.idColumn.fieldNameUpper}() == null) {
			model.set${table.idColumn.fieldNameUpper}(ID22.random());
		}
</#if>
<#if table.hasOrgan>
		${table.orgColumn.fieldTypeObject} ${table.orgColumn.fieldName} = JwtUtils.currentBearer().${table.orgColumn.fieldName};
</#if>
<#if table.hasCode>
	<#if table.hasOrgan>
		int code = commonMapper.maxCodeByTableAndOrg(Tables.${table.className}.name, ${table.orgColumn.fieldName});
	<#else>
		int code = commonMapper.maxCodeByTable(Tables.${table.className}.name);
	</#if>
		model.set${table.codeColumn.fieldNameUpper}(CommonUtil.formatCode(code));
</#if>
<#if table.hasOrgan>
		model.set${table.orgColumn.fieldNameUpper}(${table.orgColumn.fieldName});
</#if>
<#if table.hasCreator && hasLogin>
		model.set${table.creatorColumn.fieldNameUpper}(JwtUtils.currentBearer().userId);
</#if>
<#list table.columns as column>
	<#if column == table.updateColumn || column == table.createColumn>
		<#if column.fieldType == 'long'>
		model.set${column.fieldNameUpper}(System.currentTimeMillis());
		<#elseif column.fieldType == 'java.util.Date'>
		model.set${column.fieldNameUpper}(new java.util.Date());
		</#if>
	</#if>
</#list>
        mapper.insert(model);
		return model.get${table.idColumn.fieldNameUpper}();
	}

<#if table.hasId>
	/**
	 * 更新${table.remarkName}
	 * @param model 实体对象
	 × @return 返回数据修改的行数
	 */
    public int update(${className} model) {
<#if organTable == table && hasLogin>
		${orgColumn.fieldTypeObject} ${orgColumn.fieldName} = JwtUtils.currentBearer().${orgColumn.fieldName};
	<#if hasLogin && loginTable.orgColumn.nullable>
		if (${orgColumn.fieldName} != null && !${orgColumn.fieldName}.equals(model.get${table.idColumn.fieldNameUpper}())) {
	<#else>
		if (!model.get${table.idColumn.fieldNameUpper}().equals(${orgColumn.fieldName})) {
	</#if>
			throw new AccessException("权限不足");
		}
</#if>
<#list table.columns as column>
	<#if column == table.updateColumn>
		<#if column.fieldType == 'long'>
		model.set${column.fieldNameUpper}(System.currentTimeMillis());
		<#elseif column.fieldType == 'java.util.Date'>
		model.set${column.fieldNameUpper}(new java.util.Date());
		</#if>
	</#if>
</#list>
		return mapper.update(model);
	}

	/**
	 * 获取${table.remarkName}
	 * @param id 数据主键
	 × @return 数据实体对象
	 */
    public ${className} findById(Object id) {
	<#if table.hasOrgan>
		${className} model = mapper.findById(id);
		if (model == null) {
			throw new ClientException("无效的${table.remarkName}Id");
		}
		<#if hasLogin && loginTable.orgColumn.nullable>
		if (JwtUtils.currentBearer().${table.orgColumn.fieldName} == null || !JwtUtils.currentBearer().${table.orgColumn.fieldName}.equals(model.get${table.orgColumn.fieldNameUpper}())) {
		<#elseif table.orgColumn.stringType>
		if (model.get${table.orgColumn.fieldNameUpper}() == null || !model.get${table.orgColumn.fieldNameUpper}().equals(JwtUtils.currentBearer().${table.orgColumn.fieldName})) {
		<#else>
		if (JwtUtils.currentBearer().${table.orgColumn.fieldName} != model.get${table.orgColumn.fieldNameUpper}()) {
		</#if>
			throw new ClientException("无效的${table.remarkName}Id");
		}
		return model;
	<#else>
		return mapper.findById(id);
	</#if>
	}

	/**
	 * 获取${table.remarkName}
	 * @param ids 数据主键
	 × @return 返回数据修改的行数
	 */
    public int deleteById(String ids) {
	<#if table.hasOrgan || table == loginTable>
		if (!ids.contains(",")) {
		<#if table == loginTable>
			${className} model = this.findById(ids);
			<#if table.idColumn.stringType>
			if (JwtUtils.currentBearer().userId.equals(model.get${table.idColumn.fieldNameUpper}())) {
			<#else>
			if (JwtUtils.currentBearer().userId == model.get${table.idColumn.fieldNameUpper}()) {
			</#if>
				throw new ClientException("不能删除自己！");
			}
		} else {
			<#if table.idColumn.stringType>
			if (java.util.Arrays.stream(ids.split(",")).anyMatch(id->JwtUtils.currentBearer().userId.equals(id))) {
			<#else>
			if (java.util.Arrays.stream(ids.split(",")).anyMatch(id->Integer.parseInt(id)==JwtUtils.currentBearer().userId)) {
			</#if>
				throw new ClientException("不能删除自己！");
			}
		<#else >
			this.findById(ids); //调用获取接口可以验证相关合法性
		</#if>
		}
	</#if>
<#if table.hasRemove>
	<#if table.idColumn.stringType>
		List<String> list = Arrays.asList(ids.split(","));
	<#else>
		List<Integer> list = Arrays.stream(ids.split(",")).map(Integer::parseInt).collect(Collectors.toList());
	</#if>
	<#if table.removeColumn.boolType>
		return mapper.updateSetter(Tables.${className}.set${table.removeColumn.fieldNameUpper}(Boolean.TRUE).where(Tables.${className}.${table.idColumn.fieldNameUpper}.in(list)));
	<#elseif table.removeColumn.intType>
		return mapper.updateSetter(Tables.${className}.set${table.removeColumn.fieldNameUpper}(1).where(Tables.${className}.${table.idColumn.fieldNameUpper}.in(list)));
	<#else>
		return mapper.updateSetter(Tables.${className}.set${table.removeColumn.fieldNameUpper}("removed").where(Tables.${className}.${table.idColumn.fieldNameUpper}.in(list)));
	</#if>
<#else>
		return mapper.deleteById((Object[]) ids.split(","));
</#if>
	}

</#if>
}
