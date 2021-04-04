package ${packageName}.service.auto;
<#assign hasOrgColumn=false/>
<#list table.columns as column>
	<#if column == table.orgColumn>
		<#assign hasOrgColumn=true/>
		<#break />
	</#if>
</#list>
<#assign hasCodeColumn=false/>
<#list table.columns as column>
	<#if column == table.codeColumn && column.stringType>
		<#assign hasCodeColumn=true/>
		<#break />
	</#if>
</#list>

import ${packageName}.exception.ClientException;
<#if hasCodeColumn>
import ${packageName}.mapper.CommonMapper;
</#if>
<#if hasOrgColumn>
import ${packageName}.mapper.intent.Tables;
</#if>
import ${packageName}.mapper.auto.${className}Mapper;
import ${packageName}.model.api.Paged;
import ${packageName}.model.api.Paging;
import ${packageName}.model.db.${className};
<#if hasCodeColumn>
import ${packageName}.util.CommonUtil;
</#if>
<#if !table.idColumn.autoIncrement && table.idColumn.stringType>
import ${packageName}.util.ID22;
</#if>
<#if hasOrgColumn>
import ${packageName}.util.JwtUtils;
</#if>

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;


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

<#if hasCodeColumn>
	private final CommonMapper commonMapper;
</#if>
	private final ${className}Mapper mapper;

	/**
	 * ${table.remarkName}列表
	 * @param paging 分页对象
	 */
    public Paged<${className}> list(Paging paging) {
<#if hasOrgColumn>
	${table.orgColumn.fieldTypeObject} ${table.orgColumn.fieldName} = JwtUtils.currentBearer().${table.orgColumn.fieldName};
	List<${className}> list = mapper.findListCondition(paging.toRowBounds(), Tables.${table.className}.${table.orgColumn.fieldNameUpper}.eq(${table.orgColumn.fieldName}));
<#else >
	List<${className}> list = mapper.findListCondition(paging.toRowBounds(), null);
</#if>
		return new Paged<>(paging, list);
    }

	/**
	 * 添加${table.remarkName}
	 * @param model 实体对象
	 × @return 返回新数据的Id
	 */
	public ${table.idColumn.fieldType} insert(${className} model) {
<#if !table.idColumn.autoIncrement && table.idColumn.isStringType()>
		if(model.get${table.idColumn.fieldNameUpper}() == null) {
			model.set${table.idColumn.fieldNameUpper}(ID22.random());
		}
</#if>
<#if hasCodeColumn || hasOrgColumn>
		${table.orgColumn.fieldTypeObject} ${table.orgColumn.fieldName} = JwtUtils.currentBearer().${table.orgColumn.fieldName};
</#if>
<#if hasCodeColumn>
	<#if hasOrgColumn>
		int code = commonMapper.maxCodeByTableAndOrg(Tables.${table.className}.getName(), ${table.orgColumn.fieldName});
	<#else>
		int code = commonMapper.maxCodeByTable(Tables.${table.className}.getName());
	</#if>
		model.setCode(CommonUtil.formatCode(code));
</#if>
<#if hasOrgColumn>
		model.set${table.orgColumn.fieldNameUpper}(${table.orgColumn.fieldName});
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

	/**
	 * 更新${table.remarkName}
	 * @param model 实体对象
	 × @return 返回数据修改的行数
	 */
    public int update(${className} model) {
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
    public ${className} get(Object id) {
<#if hasOrgColumn>
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
<#if hasOrgColumn || table == loginTable>
		if (!ids.contains(",")) {
	<#if table == loginTable>
			${className} model = this.get(ids);
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
			this.get(ids);
	</#if>
		}
</#if>
		return mapper.deleteById((Object[]) ids.split(","));
	}

}
