package ${packageName}.controller.auto;

import ${packageName}.mapper.auto.${className}AutoMapper;
import ${packageName}.model.api.ApiResult;
import ${packageName}.model.api.Paged;
import ${packageName}.model.api.Paging;
import ${packageName}.model.db.${className};
<#if table.hasCascadeKey>
import ${packageName}.model.db.${className}Bean;
</#if>
import ${packageName}.service.auto.${className}AutoService;

import io.swagger.annotations.*;
import lombok.AllArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import springfox.documentation.annotations.ApiIgnore;

<#if !table.hasOrgan && !table.hasSearches>
import java.util.List;
</#if>

<#assign beans = ['']/>
<#if table.hasCascadeKey>
	<#assign beans = ['', 'Bean']/>
</#if>
/**
 * ${table.remark} 的 Controller 层实现
<#list table.descriptions as description>
 * ${description}
</#list>
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@AllArgsConstructor
@Api(tags = "${table.remarkName}")
@RequestMapping("/api/auto/${table.urlPathName}")
@RestController("auto${className}Controller")
public class ${className}Controller {

<#--<#if !table.hasOrgan && !table.hasCode && !table.hasCreate && !table.hasUpdate && table != loginTable && !(table.hasId && !table.idColumn.autoIncrement && table.idColumn.stringType)>-->
	private final ${className}AutoMapper mapper;
<#--</#if>-->
<#if table.hasSearches || table.hasImportCascadeKey || table.hasOrgan || table.hasCode || table.hasCreate || table.hasUpdate || table == loginTable || (table.hasId && !table.idColumn.autoIncrement && table.idColumn.stringType)>
	private final ${className}AutoService service;
</#if>
<#list beans as bean>

	<#assign value = '${table.remarkName}列表'/>
	<#if bean?length gt 0>
		<#assign value = value + '（包括外键）'/>
	</#if>
	<#assign notes = '分页参数支持两种形式，page 页数，skip 起始数据，两个传一个即可'/>
	<#if table.hasSearches>
		<#assign keys = '可以通过'/>
		<#list table.searchColumns as column>
			<#assign keys = keys + '[${column.remarkName}]'/>
			<#if column_has_next>
				<#assign keys = keys + '、'/>
			</#if>
		</#list>
		<#assign keys = keys + '等关键字搜索'/>
		<#assign notes = keys + '\\n' + notes/>
	</#if>
	@GetMapping<#if bean?length gt 0>("${bean?lower_case}")</#if>
	@ApiOperation(value = "${value}", notes = "${notes}")
	@ApiImplicitParams({
	<#if table.hasSearches>
		@ApiImplicitParam(paramType = "query", name = "key", value = "搜索关键字"),
	</#if>
		@ApiImplicitParam(paramType = "query", name = "size", value = "分页大小（配合 page 或 skip 组合使用）", required = true, defaultValue = "20"),
		@ApiImplicitParam(paramType = "query", name = "page", value = "分页页码（0开始，如果使用 skip 可不传）", defaultValue = "0"),
		@ApiImplicitParam(paramType = "query", name = "skip", value = "分页开始（0开始，如果使用 page 可不传）", defaultValue = "0")
	})
    public ApiResult<Paged<${className}${bean}>> list${bean}(@ApiIgnore Paging paging<#if table.hasSearches>, String key</#if>) {
	<#if table.hasOrgan || table.hasSearches>
		return ApiResult.success(service.list${bean}(paging<#if table.hasSearches>, key</#if>));
	<#else >
		List<${className}${bean}> list = mapper.select${bean}Where(null, paging.toRowBounds());
		return ApiResult.success(new Paged<>(paging, list));
	</#if>
    }
	<#list table.importCascadeKeys as key>

	@GetMapping("${bean?lower_case}/by/${key.fkColumn.fieldName}")
	@ApiOperation(value = "根据${key.pkTable.remarkName}获取${value}", notes = "${notes}")
	@ApiImplicitParams({
		@ApiImplicitParam(paramType = "query", name = "${key.fkColumn.fieldName}", value = "${key.pkTable.remarkName}关联", required = true),
		<#if table.hasSearches>
		@ApiImplicitParam(paramType = "query", name = "key", value = "搜索关键字"),
		</#if>
		@ApiImplicitParam(paramType = "query", name = "size", value = "分页大小（配合 page 或 skip 组合使用）", required = true, defaultValue = "20"),
		@ApiImplicitParam(paramType = "query", name = "page", value = "分页页码（0开始，如果使用 skip 可不传）", defaultValue = "0"),
		@ApiImplicitParam(paramType = "query", name = "skip", value = "分页开始（0开始，如果使用 page 可不传）", defaultValue = "0")
	})
	public ApiResult<Paged<${className}${bean}>> list${bean}By${key.fkColumn.fieldNameUpper}(${key.fkColumn.fieldType} ${key.fkColumn.fieldName}, @ApiIgnore Paging paging<#if table.hasSearches>, String key</#if>) {
		return ApiResult.success(service.list${bean}By${key.fkColumn.fieldNameUpper}(${key.fkColumn.fieldName}, paging<#if table.hasSearches>, key</#if>));
	}
	</#list>
	<#list table.relateCascadeKeys as key>

	@GetMapping("${bean?lower_case}/relate/${key.relateTargetColumn.fieldName}")
	@ApiOperation(value = "根据${key.targetTable.remarkName}级联查询${value}", notes = "${notes}")
	@ApiImplicitParams({
		@ApiImplicitParam(paramType = "query", name = "${key.relateTargetColumn.fieldName}", value = "${key.relateTargetColumn.remarkName}关联", required = true),
		@ApiImplicitParam(paramType = "query", name = "size", value = "分页大小（配合 page 或 skip 组合使用）", required = true, defaultValue = "20"),
		@ApiImplicitParam(paramType = "query", name = "page", value = "分页页码（0开始，如果使用 skip 可不传）", defaultValue = "0"),
		@ApiImplicitParam(paramType = "query", name = "skip", value = "分页开始（0开始，如果使用 page 可不传）", defaultValue = "0")
	})
	public ApiResult<Paged<${className}${bean}>> list${bean}ByRelate${key.relateTargetColumn.fieldNameUpper}(${key.relateTargetColumn.fieldType} ${key.relateTargetColumn.fieldName}, @ApiIgnore Paging paging) {
		List<${className}${bean}> list = mapper.select${bean}ByRelate${key.relateTargetColumn.fieldNameUpper}(${key.relateTargetColumn.fieldName}, paging.toRowBounds());
		return ApiResult.success(new Paged(paging, list));
	}
	</#list>
</#list>

    @PostMapping
    @ApiOperation(value = "添加${table.remarkName}", notes = "返回新数据的Id")
    @ApiImplicitParams({
<#list table.columns as column>
	<#if column != table.idColumn && !column.hiddenForSubmit>
		@ApiImplicitParam(paramType = "form", name = "${column.fieldName}", value = "${column.remark}<#if column.stringType && !column.name?matches("^\\w+?(ID|CODE)$")>（最多${column.length}字符）</#if>", dataType = "${column.fieldType?replace("short","int")?replace("java.util.Date","date")?lower_case}" <#if column.nullable!=true>, required = true</#if><#if column.defValue?length != 0>, defaultValue = "${column.defValue?trim}"</#if>)<#if column_has_next>,</#if>
	</#if>
</#list>
    })
	public ApiResult<${table.idColumn.fieldTypeObject}> insert(@Validated @ApiIgnore ${className} model) {
<#if table.hasOrgan || table.hasCode || table.hasCreate || table.hasUpdate || (table.hasId && !table.idColumn.autoIncrement && table.idColumn.stringType)>
		service.insert(model);
<#else>
        mapper.insert(model);
</#if>
		return ApiResult.success(model.get${table.idColumn.fieldNameUpper}());
	}

<#if table.hasId>
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
	<#if table.hasOrgan || table.hasCreate || table.hasUpdate>
		return ApiResult.success(service.update(model));
	<#else>
		return ApiResult.success(mapper.update(model));
	</#if>
	}
	<#list beans as bean>

	@GetMapping("${bean?lower_case}/{id}")
	@ApiOperation(value = "获取${table.remarkName}<#if bean?length gt 0>（包括外键）</#if>")
    public ApiResult<${className}${bean}> find${bean}ById(@PathVariable @ApiParam(value = "${table.remark}Id", required = true) String id) {
		<#if table.hasOrgan>
		return ApiResult.success(service.find${bean}ById(id));
		<#else>
		return ApiResult.success(mapper.find${bean}ById(id));
		</#if>
	}
	</#list>

	@DeleteMapping("/{ids}")
	@ApiOperation(value = "删除${table.remarkName}")
    public ApiResult<Integer> deleteById(@PathVariable @ApiParam(value = "${table.remark}Ids", required = true) String ids) {
	<#if table.hasOrgan || table == loginTable>
		return ApiResult.success(service.deleteById(ids));
	<#else>
		return ApiResult.success(mapper.deleteById((Object[]) ids.split(",")));
	</#if>
	}

</#if>
}
