package ${packageName}.service.auto;

<#if table.hasSearches || (loginTables?seq_contains(table) && table.hasUsername && table.hasId)>
import com.github.pagehelper.util.StringUtil;
</#if>
<#if table == organTable && hasLogin>
import ${packageName}.exception.AccessException;
</#if>
<#if (table.hasOrgan && hasLogin) || (loginTables?seq_contains(table) && table.hasUsername)>
import ${packageName}.exception.ClientException;
</#if>
<#if table.hasCode>
import ${packageName}.mapper.CommonMapper;
</#if>
import ${packageName}.mapper.intent.Tables;
import ${packageName}.mapper.auto.${className}AutoMapper;
import ${packageName}.mapper.intent.api.WhereQuery;
import ${packageName}.model.api.Paged;
import ${packageName}.model.api.Paging;
<#if table == loginTable && table.hasPassword>
import ${packageName}.model.conf.AuthConfig;
</#if>
import ${packageName}.model.db.${className};
<#if table.hasCascadeKey>
import ${packageName}.model.db.${className}Bean;
</#if>
<#if table.hasCode>
import ${packageName}.util.CommonUtil;
</#if>
<#if table.hasId && !table.idColumn.autoIncrement && table.idColumn.stringType>
import ${packageName}.util.ID22;
</#if>
<#if table.hasId && !table.idColumn.autoIncrement && table.idColumn.longType>
import ${packageName}.util.SnowflakeUtil;
</#if>
<#if table == loginTable || (table.hasOrgan && hasLogin) || (table == organTable  && hasLogin) || (hasLogin && table.hasCreator)>
import ${packageName}.security.JwtUtils;
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

<#assign beans = ['']/>
<#if table.hasCascadeKey>
	<#assign beans = ['', 'Bean']/>
</#if>
/**
 * ${table.remark} 的 Service 层实现
<#list table.descriptions as description>
 * ${description}
</#list>
 *
 * 由代码生成器生成，不要修改
 * 当数据库有更新，使用生成器再次生成时，会覆盖所有修改
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@AllArgsConstructor
@Service("auto${className}Service")
public class ${className}AutoService {

<#if table == loginTable && table.hasPassword>
	private final AuthConfig config;
</#if>
<#if table.hasCode>
	private final CommonMapper commonMapper;
</#if>
	private final ${className}AutoMapper mapper;
<#list beans as bean>

	/**
	 * ${table.remarkName}列表<#if bean?length gt 0>（包括外键）</#if>
	 * @param paging 分页对象
	<#if table.hasSearches>
	 * @param key 搜索关键字
	</#if>
	 */
    public Paged<${className}${bean}> list${bean}(Paging paging<#if table.hasSearches>, String key</#if>) {
	<#if table.hasOrgan && hasOrgan && hasLogin>
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
	<#if table.hasSearches>
		if (StringUtil.isNotEmpty(key)) {
			where = where.and(<#list table.searchColumns as column><#if column_index gt 0>.or(</#if>Tables.${table.className}.${column.fieldNameUpper}.contains(<#if column.stringType>key<#else>${column.fieldTypeObject}.valueOf(key)</#if>)<#if column_index gt 0>)</#if></#list>);
		}
	</#if>
		List<${className}${bean}> list = mapper.select${bean}Where(where, paging.toRowBounds());
		return new Paged<>(paging, list);
    }

	<#list table.importedKeys as key>

	/**
	 * 根据${key.pkTable.remarkName}获取${table.remarkName}列表<#if bean?length gt 0>（包括外键）</#if>
	 * @param paging 分页对象
	 <#if table.hasSearches>
	 * @param key 搜索关键字
	 </#if>
	 */
	public Paged<${className}${bean}> list${bean}By${key.fkColumn.fieldNameUpper}(${key.fkColumn.fieldType} ${key.fkColumn.fieldName}, Paging paging<#if table.hasSearches>, String key</#if>) {
		WhereQuery<${className}> where = Tables.${table.className}.${key.fkColumn.fieldNameUpper}.eq(${key.fkColumn.fieldName});
	<#if table.hasRemove>
		<#if table.removeColumn.boolType>
		where = where.and(Tables.${className}.${table.removeColumn.fieldNameUpper}.isNull().or(Tables.${className}.${table.removeColumn.fieldNameUpper}.eq(Boolean.FALSE)));
		<#elseif table.removeColumn.intType>
		where = where.and(Tables.${className}.${table.removeColumn.fieldNameUpper}.isNull().or(Tables.${className}.${table.removeColumn.fieldNameUpper}.eq(0)));
		<#else>
		where = where.and(Tables.${className}.${table.removeColumn.fieldNameUpper}.isNull().or(Tables.${className}.${table.removeColumn.fieldNameUpper}.ne("removed")));
		</#if>
	</#if>
	<#if table.hasSearches>
		if (StringUtil.isNotEmpty(key)) {
			where = where.and(<#list table.searchColumns as column><#if column_index gt 0>.or(</#if>Tables.${table.className}.${column.fieldNameUpper}.contains(key)<#if column_index gt 0>)</#if></#list>);
		}
	</#if>
		List<${className}${bean}> list = mapper.select${bean}Where(where, paging.toRowBounds());
		return new Paged<>(paging, list);
	}
	</#list>
</#list>

	/**
	 * 添加${table.remarkName}
	 * @param model 实体对象
	 × @return 返回新数据的Id
	 */
	public ${table.idColumn.fieldType} insert(${className} model) {
<#if loginTables?seq_contains(table) && table.hasUsername>
		if (mapper.countWhere(Tables.${className}.${table.usernameColumn.fieldNameUpper}.eq(model.get${table.usernameColumn.fieldNameUpper}())) > 0) {
			throw new ClientException("已经存在用户名：" + model.get${table.usernameColumn.fieldNameUpper}());
		}
</#if>
<#if table.hasId && !table.idColumn.autoIncrement && table.idColumn.stringType>
		if(model.get${table.idColumn.fieldNameUpper}() == null) {
			model.set${table.idColumn.fieldNameUpper}(ID22.random());
		}
</#if>
<#if table.hasId && !table.idColumn.autoIncrement && table.idColumn.longType>
		if(model.get${table.idColumn.fieldNameUpper}() == 0L) {
			model.set${table.idColumn.fieldNameUpper}(SnowflakeUtil.nextId());
		}
</#if>
<#if table.hasOrgan && hasLogin>
		${table.orgColumn.fieldTypeObject} ${table.orgColumn.fieldName} = JwtUtils.currentBearer().${table.orgColumn.fieldName};
</#if>
<#if table.hasCode && table.codeColumn.stringType>
	<#if table.hasOrgan && hasLogin>
		int code = commonMapper.maxCodeByTableAndOrg(Tables.${table.className}.name, ${table.orgColumn.fieldName});
	<#else>
		int code = commonMapper.maxCodeByTable(Tables.${table.className}.name);
	</#if>
		model.set${table.codeColumn.fieldNameUpper}(CommonUtil.formatCode(code));
</#if>
<#if table.hasOrgan && hasLogin>
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
<#if table == loginTable && table.hasPassword>
		if (model.get${table.passwordColumn.fieldNameUpper}() != null) {
			model.set${table.passwordColumn.fieldNameUpper}(config.passwordHash(model.get${table.passwordColumn.fieldNameUpper}()));
		}
</#if>
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
	<#if organTable == table && hasOrgan>
		${orgColumn.fieldTypeObject} ${orgColumn.fieldName} = JwtUtils.currentBearer().${orgColumn.fieldName};
		<#if hasLogin && loginTable.orgColumn.nullable>
		if (${orgColumn.fieldName} != null && !${orgColumn.fieldName}.equals(model.get${table.idColumn.fieldNameUpper}())) {
		<#else>
		if (!model.get${table.idColumn.fieldNameUpper}().equals(${orgColumn.fieldName})) {
		</#if>
			throw new AccessException("权限不足");
		}
	</#if>
<#if loginTables?seq_contains(table) && table.hasUsername && table.hasId>
		if (StringUtil.isNotEmpty(model.get${table.usernameColumn.fieldNameUpper}())) {
			if (mapper.countWhere(Tables.${className}.${table.usernameColumn.fieldNameUpper}.eq(model.get${table.usernameColumn.fieldNameUpper}()).and(Tables.${className}.${table.idColumn.fieldNameUpper}.ne(model.get${table.idColumn.fieldNameUpper}()))) > 0) {
				throw new ClientException("已经存在用户名：" + model.get${table.usernameColumn.fieldNameUpper}());
			}
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
	<#list beans as bean>

	/**
	 * 获取${table.remarkName}<#if bean?length gt 0>（包括外键）</#if>
	 * @param id 数据主键
	 × @return 数据实体对象
	 */
    public ${className}${bean} find${bean}ById(Object id) {
	<#if table.hasOrgan && hasOrgan && hasLogin>
		${className}${bean} model = mapper.find${bean}ById(id);
		if (model == null) {
			throw new ClientException("无效的${table.remarkName}Id");
		}
		<#if loginTable.orgColumn.nullable>
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
		return mapper.find${bean}ById(id);
	</#if>
	}
	</#list>

	/**
	 * 获取${table.remarkName}
	 * @param ids 数据主键
	 × @return 返回数据修改的行数
	 */
    public int deleteById(String ids) {
	<#if (table.hasOrgan && hasOrgan) || table == loginTable>
		if (!ids.contains(",")) {
		<#if table == loginTable>
			${className} model = this.findById(ids);
			<#if table.idColumn.stringType>
			if (model != null && JwtUtils.currentBearer().userId.equals(model.get${table.idColumn.fieldNameUpper}())) {
			<#else>
			if (model != null && JwtUtils.currentBearer().userId == model.get${table.idColumn.fieldNameUpper}()) {
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
