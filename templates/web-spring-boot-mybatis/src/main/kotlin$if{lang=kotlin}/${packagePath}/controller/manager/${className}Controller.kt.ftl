package ${packageName}.controller.manager
<#assign hasSearch=false/>
<#list table.columns as column>
	<#if column.name?lower_case?contains('name') || column.name?lower_case?contains('title') >
		<#assign searchColumn=column/>
		<#assign hasSearch=true/>
		<#break />
	</#if>
</#list>

import ${packageName}.mapper.auto.${className}Mapper
import ${packageName}.model.api.ApiResult
import ${packageName}.model.api.Paged
import ${packageName}.model.api.Paging
import ${packageName}.model.db.${className}
import ${packageName}.service.auto.${className}Service
import ${packageName}.util.RequestUtil

import io.swagger.annotations.*
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.validation.annotation.Validated
import org.springframework.web.bind.annotation.*
import springfox.documentation.annotations.ApiIgnore

/**
 * ${table.remark} 的 Controller 层实现
<#list table.descriptions as description>
 * ${description}
</#list>
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Api(tags = ["${table.remark}"])
@RequestMapping("/api/v1/${table.urlPathName}")
@RestController("auto${className}Controller")
class ${className}Controller {

<#--<#if !table.hasOrgan && !table.hasCode && !table.hasCreate && !table.hasUpdate && table != loginTable && !(table.hasId && !table.idColumn.autoIncrement && table.idColumn.stringType)>-->
	@Autowired
	private lateinit var mapper: ${className}Mapper
<#--</#if>-->
<#if hasSearch || table.hasOrgan || table.hasCode || table.hasCreate || table.hasUpdate || table == loginTable || (table.hasId && !table.idColumn.autoIncrement && table.idColumn.stringType)>
	@Autowired
	private lateinit var service: ${className}Service
</#if>

	@GetMapping
	@ApiOperation(value = "${table.remarkName}列表", notes = "分页参数支持两种形式，page 页数，skip 起始数据，两个传一个即可")
	@ApiImplicitParams(
<#if hasSearch>
		ApiImplicitParam(paramType = "query", name = "key", value = "索索关键字"),
</#if>
		ApiImplicitParam(paramType = "query", name = "size", value = "分页大小（配合 page 或 skip 组合使用）", required = true, defaultValue = "20"),
		ApiImplicitParam(paramType = "query", name = "page", value = "分页页码（0开始，如果使用 skip 可不传）", defaultValue = "0"),
		ApiImplicitParam(paramType = "query", name = "skip", value = "分页开始（0开始，如果使用 page 可不传）", defaultValue = "0")
	)
    fun list(@ApiIgnore paging: Paging<#if hasSearch>, key: String</#if>): ApiResult<Paged<${className}>> {
<#if table.hasOrgan || hasSearch>
		return ApiResult.success(service.list(paging<#if hasSearch>, key</#if>))
<#else >
		val list = mapper.selectWhere(null, paging.toRowBounds())
		return ApiResult.success(Paged(paging, list))
</#if>
    }

    @PostMapping
    @ApiOperation(value = "添加${table.remarkName}", notes = "返回新数据的Id")
    @ApiImplicitParams(
<#list table.columns as column>
	<#if column != table.idColumn && !column.hiddenForSubmit>
		ApiImplicitParam(paramType = "form", name = "${column.fieldName}", value = "${column.remark}<#if column.stringType && !column.name?matches("^\\w+?(ID|CODE)$")>（最多${column.length}字符）</#if>", dataType = "${column.fieldType?replace("short","int")?replace("java.util.Date","date")?lower_case}" <#if column.nullable!=true>, required = true</#if><#if column.defValue?length != 0>, defaultValue = "${column.defValue?trim}"</#if>)<#if column_has_next>,</#if>
	</#if>
</#list>
    )
	fun insert(@Validated @ApiIgnore model: ${className}): ApiResult<${table.idColumn.fieldType}> {
		RequestUtil.validate(model)
<#if table.hasOrgan || table.hasCode || table.hasCreate || table.hasUpdate || (table.hasId && !table.idColumn.autoIncrement && table.idColumn.stringType)>
		service.insert(model)
<#else>
        mapper.insert(model)
</#if>
		return ApiResult.success(model.${table.idColumn.fieldName})
	}

<#if table.hasId>
	@PutMapping
	@ApiOperation(value = "更新${table.remarkName}", notes = "返回数据修改的行数")
	@ApiImplicitParams(
	<#list table.columns as column>
		<#if !column.hiddenForSubmit || column == table.idColumn>
		ApiImplicitParam(paramType = "form", name = "${column.fieldName}", value = "${column.remark}<#if column.stringType && !column.name?matches("^\\w+?(ID|CODE)$")>（最多${column.length}字符）</#if>", dataType = "${column.fieldType?replace("short","int")?replace("java.util.Date","date")?lower_case}" <#if column.defValue?length != 0>, defaultValue = "${column.defValue?trim}"</#if>)<#if column_has_next>,</#if>
		</#if>
	</#list>
	)
    fun update(@Validated @ApiIgnore model: ${className}): ApiResult<Int> {
	<#if table.hasOrgan || table.hasCreate || table.hasUpdate>
		return ApiResult.success(service.update(model))
	<#else>
		return ApiResult.success(mapper.update(model))
	</#if>
	}

	@GetMapping("/{id}")
	@ApiOperation(value = "获取${table.remarkName}")
    fun findById(@PathVariable @ApiParam("${table.remark}Id") id: String): ApiResult<${className}> {
	<#if table.hasOrgan>
		return ApiResult.success(service.findById(id))
	<#else>
		return ApiResult.success(mapper.findById(id))
	</#if>
	}

	@DeleteMapping("/{ids}")
	@ApiOperation(value = "删除${table.remarkName}")
    fun deleteById(@PathVariable @ApiParam("${table.remark}Ids") ids: String): ApiResult<Int> {
	<#if table.hasOrgan || table == loginTable>
		return ApiResult.success(service.deleteById(ids))
	<#else>
		return ApiResult.success(mapper.deleteById(*ids.split(",").toTypedArray()))
	</#if>
	}

</#if>
}
