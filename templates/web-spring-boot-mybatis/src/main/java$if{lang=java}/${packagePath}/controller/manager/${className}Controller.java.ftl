package ${packageName}.controller.manager;
<#assign hasSearch=false/>
<#list table.columns as column>
	<#if column.name?lower_case?contains('name')>
		<#assign searchColumn=column/>
		<#assign hasSearch=true/>
		<#break />
	</#if>
</#list>

import ${packageName}.mapper.auto.${className}Mapper;
import ${packageName}.model.api.ApiResult;
import ${packageName}.model.api.Paged;
import ${packageName}.model.api.Paging;
import ${packageName}.model.db.${className};
import ${packageName}.service.auto.${className}Service;

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

<#--<#if !table.hasOrg && !table.hasCode && !table.hasCreate && !table.hasUpdate && table != loginTable && !(table.hasId && !table.idColumn.autoIncrement && table.idColumn.stringType)>-->
	private final ${className}Mapper mapper;
<#--</#if>-->
<#if hasSearch || table.hasOrg || table.hasCode || table.hasCreate || table.hasUpdate || table == loginTable || (table.hasId && !table.idColumn.autoIncrement && table.idColumn.stringType)>
	private final ${className}Service service;
</#if>

	@GetMapping
	@ApiOperation(value = "${table.remarkName}列表", notes = "分页参数支持两种形式，page 页数，skip 起始数据，两个传一个即可")
	@ApiImplicitParams({
<#if hasSearch>
		@ApiImplicitParam(paramType = "query", name = "key", value = "索索关键字"),
</#if>
		@ApiImplicitParam(paramType = "query", name = "size", value = "分页大小（配合 page 或 skip 组合使用）", required = true, defaultValue = "20"),
		@ApiImplicitParam(paramType = "query", name = "page", value = "分页页码（0开始，如果使用 skip 可不传）", defaultValue = "0"),
		@ApiImplicitParam(paramType = "query", name = "skip", value = "分页开始（0开始，如果使用 page 可不传）", defaultValue = "0")
	})
    public ApiResult<Paged<${className}>> list(@ApiIgnore Paging paging<#if hasSearch>, String key</#if>) {
<#if table.hasOrg || hasSearch>
		return ApiResult.success(service.list(paging<#if hasSearch>, key</#if>));
<#else >
		List<${className}> list = mapper.selectWhere(null, paging.toRowBounds());
		return ApiResult.success(new Paged<>(paging, list));
</#if>
    }

    @PostMapping
    @ApiOperation(value = "添加${table.remarkName}", notes = "返回新数据的Id")
    @ApiImplicitParams({
<#list table.columns as column>
	<#if column != table.idColumn && !column.hiddenForSubmit>
		@ApiImplicitParam(paramType = "form", name = "${column.fieldName}", value = "${column.remark}<#if column.stringType && !column.name?matches("^\\w+?(ID|CODE)$")>（最多${column.length}字符）</#if>", dataType = "${column.fieldType?replace("short","int")?replace("java.util.Date","date")?lower_case}" <#if column.nullable!=true>, required = true</#if><#if column.defValue?length != 0>, defaultValue = "${column.defValue?trim}"</#if>)<#if column_has_next>,</#if>
	</#if>
</#list>
    })
	public ApiResult<Object> insert(@Validated @ApiIgnore ${className} model) {
<#if table.hasOrg || table.hasCode || table.hasCreate || table.hasUpdate || (table.hasId && !table.idColumn.autoIncrement && table.idColumn.stringType)>
		service.insert(model);
<#else>
        mapper.insert(model);
</#if>
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
<#if table.hasOrg || table.hasCreate || table.hasUpdate>
		return ApiResult.success(service.update(model));
<#else>
		return ApiResult.success(mapper.update(model));
</#if>
	}

<#if table.hasId>
	@ApiOperation(value = "获取${table.remarkName}")
	@GetMapping("/{id}")
    public ApiResult<${className}> findById(@PathVariable @ApiParam("${table.remark}Id") String id) {
	<#if table.hasOrg>
		return ApiResult.success(service.findById(id));
	<#else>
		return ApiResult.success(mapper.findById(id));
	</#if>
	}

</#if>
	@ApiOperation(value = "删除${table.remarkName}")
	@DeleteMapping("/{ids}")
    public ApiResult<Integer> deleteById(@PathVariable @ApiParam("${table.remark}Ids") String ids) {
<#if table.hasOrg || table == loginTable>
		return ApiResult.success(service.deleteById(ids));
<#else>
		return ApiResult.success(mapper.deleteById((Object[]) ids.split(",")));
</#if>
	}

}
