package ${packageName}.controller.manager;
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

<#if hasCodeColumn>
import ${packageName}.mapper.CommonMapper;
</#if>
<#if hasOrgColumn>
import ${packageName}.mapper.intent.Tables;
</#if>
import ${packageName}.mapper.auto.${className}Mapper;
import ${packageName}.model.api.ApiResult;
import ${packageName}.model.api.Paged;
import ${packageName}.model.api.Paging;
import ${packageName}.model.db.${className};
import ${packageName}.service.auto.${className}Service;
<#if hasCodeColumn>
import ${packageName}.util.CommonUtil;
</#if>
<#if !table.idColumn.autoIncrement && table.idColumn.stringType>
import ${packageName}.util.ID22;
</#if>
<#if hasOrgColumn>
import ${packageName}.util.JwtUtils;
</#if>

import io.swagger.annotations.*;
import lombok.AllArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import springfox.documentation.annotations.ApiIgnore;

import java.util.List;

/**
 * ${table.remark} 的 Controller 层实现
<#list table.descriptions as description>
 * ${description}
</#list>
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@AllArgsConstructor
@Api(tags = "${table.remark}")
@RequestMapping("/api/v1/${table.urlPathName}")
@RestController("auto${className}Controller")
public class ${className}Controller {

<#if hasCodeColumn>
	private final CommonMapper commonMapper;
</#if>
	private final ${className}Mapper mapper;
	private final ${className}Service service;

	@GetMapping
	@ApiOperation(value = "${table.remarkName}列表", notes = "分页参数支持两种形式，page 页数，skip 起始数据，两个传一个即可")
	@ApiImplicitParams({
		@ApiImplicitParam(paramType = "query", name = "size", value = "分页大小（配合 page 或 skip 组合使用）", required = true, defaultValue = "20"),
		@ApiImplicitParam(paramType = "query", name = "page", value = "分页页码（0开始，如果使用 skip 可不传）", defaultValue = "0"),
		@ApiImplicitParam(paramType = "query", name = "skip", value = "分页开始（0开始，如果使用 page 可不传）", defaultValue = "0")
	})
    public ApiResult<Paged<${className}>> list(@ApiIgnore Paging paging) {
<#if hasOrgColumn>
		${table.orgColumn.fieldTypeObject} ${table.orgColumn.fieldName} = JwtUtils.currentBearer().${table.orgColumn.fieldName};
		List<${className}> list = mapper.findListCondition(paging.toRowBounds(), Tables.${table.className}.${table.orgColumn.fieldNameUpper}.eq(${table.orgColumn.fieldName}));
<#else >
		List<${className}> list = mapper.findListCondition(paging.toRowBounds(), null);
</#if>
		return ApiResult.success(new Paged<>(paging, list));
    }

    @PostMapping
    @ApiOperation(value = "添加${table.remarkName}", notes = <#if !table.idColumn.autoIncrement && table.idColumn.isStringType()>"返回新数据的Id"<#else>"返回是否成功"</#if>)
    @ApiImplicitParams({
<#list table.columns as column>
	<#if column != table.idColumn && !column.hiddenForSubmit>
		@ApiImplicitParam(paramType = "form", name = "${column.fieldName}", value = "${column.remark}<#if column.stringType && !column.name?matches("^\\w+?(ID|CODE)$")>（最多${column.length}字符）</#if>", dataType = "${column.fieldType?replace("short","int")?replace("java.util.Date","date")?lower_case}" <#if column.nullable!=true>, required = true</#if><#if column.defValue?length != 0>, defaultValue = "${column.defValue?trim}"</#if>)<#if column_has_next>,</#if>
	</#if>
</#list>
    })
	public ApiResult<Object> insert(@Validated @ApiIgnore ${className} model) {
<#if !table.idColumn.autoIncrement && table.idColumn.isStringType()>
		//if(model.get${table.idColumn.fieldNameUpper}() == null) {
		//    model.set${table.idColumn.fieldNameUpper}(ID22.random());
		//}
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
		//model.set${column.fieldNameUpper}(System.currentTimeMillis());
		<#elseif column.fieldType == 'java.util.Date'>
		//model.set${column.fieldNameUpper}(new java.util.Date());
		</#if>
	</#if>
</#list>
        //mapper.insert(model);
		service.insert(model);
		return ApiResult.success(model.get${table.idColumn.fieldNameUpper}());
	}

	@PutMapping
	@ApiOperation(value = "更新${table.remarkName}", notes = "返回数据修改的行数")
	@ApiImplicitParams({
<#list table.columns as column>
	<#if !column.hiddenForSubmit>
		@ApiImplicitParam(paramType = "form", name = "${column.fieldName}", value = "${column.remark}<#if column.stringType && !column.name?matches("^\\w+?(ID|CODE)$")>（最多${column.length}字符）</#if>", dataType = "${column.fieldType?replace("short","int")?replace("java.util.Date","date")?lower_case}" <#if column.defValue?length != 0>, defaultValue = "${column.defValue?trim}"</#if>)<#if column_has_next>,</#if>
	</#if>
</#list>
	})
    public ApiResult<Integer> update(@Validated @ApiIgnore ${className} model) {
<#if hasOrgColumn>
		${className} ${table.classNameCamel} = mapper.findById(model.get${table.idColumn.fieldNameUpper}());
		if (${table.classNameCamel} == null) {
			return ApiResult.failure400("无效的${table.remarkName}Id");
		}
	<#if table.orgColumn.stringType>
		if (${table.classNameCamel}.get${table.orgColumn.fieldNameUpper}() == null || !${table.classNameCamel}.get${table.orgColumn.fieldNameUpper}().equals(JwtUtils.currentBearer().${table.orgColumn.fieldName})) {
	<#else>
		if (JwtUtils.currentBearer().${table.orgColumn.fieldName} != ${table.classNameCamel}.get${table.orgColumn.fieldNameUpper}()) {
	</#if>
			return ApiResult.failure400("无效的${table.remarkName}Id");
		}
</#if>
<#list table.columns as column>
	<#if column == table.updateColumn>
		<#if column.fieldType == 'long'>
		//model.set${column.fieldNameUpper}(System.currentTimeMillis());
		<#elseif column.fieldType == 'java.util.Date'>
		//model.set${column.fieldNameUpper}(new java.util.Date());
		</#if>
	</#if>
</#list>
		//return ApiResult.success(mapper.update(model));
		return ApiResult.success(service.update(model));
	}

	@ApiOperation(value = "获取${table.remarkName}")
	@GetMapping("/{id}")
    public ApiResult<${className}> get(@PathVariable @ApiParam("${table.remark}Id") String id) {
<#if hasOrgColumn>
		${className} model = mapper.findById(id);
		if (model == null) {
			return ApiResult.failure400("无效的${table.remarkName}Id");
		}
	<#if table.orgColumn.stringType>
		if (model.get${table.orgColumn.fieldNameUpper}() == null || !model.get${table.orgColumn.fieldNameUpper}().equals(JwtUtils.currentBearer().${table.orgColumn.fieldName})) {
	<#else>
		if (JwtUtils.currentBearer().${table.orgColumn.fieldName} != model.get${table.orgColumn.fieldNameUpper}()) {
	</#if>
			return ApiResult.failure400("无效的${table.remarkName}Id");
		}
		return ApiResult.success(model);
<#else>
		return ApiResult.success(mapper.findById(id));
</#if>
	}

	@ApiOperation(value = "删除${table.remarkName}")
	@DeleteMapping("/{ids}")
    public ApiResult<Integer> deleteById(@PathVariable @ApiParam("${table.remark}Ids") String ids) {
<#if hasOrgColumn || table == loginTable>
		if (!ids.contains(",")) {
			${className} model = mapper.findById(ids);
			if (model == null) {
				return ApiResult.failure400("无效的${table.remarkName}Id");
			}
	<#if hasOrgColumn>
		<#if table.orgColumn.stringType>
			if (model.get${table.orgColumn.fieldNameUpper}() == null || !model.get${table.orgColumn.fieldNameUpper}().equals(JwtUtils.currentBearer().${table.orgColumn.fieldName})) {
		<#else>
			if (JwtUtils.currentBearer().${table.orgColumn.fieldName} != model.get${table.orgColumn.fieldNameUpper}()) {
		</#if>
				return ApiResult.failure400("无效的${table.remarkName}Id");
			}
	</#if>
	<#if table == loginTable>
		<#if table.idColumn.stringType>
			if (JwtUtils.currentBearer().userId.equals(model.get${table.idColumn.fieldNameUpper}())) {
		<#else>
			if (JwtUtils.currentBearer().userId == model.get${table.idColumn.fieldNameUpper}()) {
		</#if>
				return ApiResult.failure400("不能删除自己！");
			}
		} else {
		<#if table.idColumn.stringType>
			if (java.util.Arrays.stream(ids.split(",")).anyMatch(id->JwtUtils.currentBearer().userId.equals(id))) {
		<#else>
			if (java.util.Arrays.stream(ids.split(",")).anyMatch(id->Integer.parseInt(id)==JwtUtils.currentBearer().userId)) {
		</#if>
				return ApiResult.failure400("不能删除自己！");
			}
	</#if>
		}
</#if>
		return ApiResult.success(mapper.deleteById((Object[]) ids.split(",")));
	}

}
