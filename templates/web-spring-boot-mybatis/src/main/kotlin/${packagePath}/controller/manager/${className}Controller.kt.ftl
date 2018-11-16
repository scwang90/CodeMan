package ${packageName}.controller.manager

import ${packageName}.mapper.common.${className}Mapper
import ${packageName}.model.api.ApiResult
import ${packageName}.model.api.Paged
import ${packageName}.model.api.Paging
import ${packageName}.model.db.${className}
import io.swagger.annotations.*
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.validation.annotation.Validated
import org.springframework.web.bind.annotation.*
import springfox.documentation.annotations.ApiIgnore

/**
 * ${table.remark} 的 Controller 层实现
 * @author ${author}
 * @since ${.now?string("yyyy-MM-dd HH:mm:ss zzzz")}
 */
@RestController
@Api("${table.classNameLower}", description = "${table.remark}API")
@RequestMapping("/api/v1/${table.classNameLower}")
class ${className}Controller {


//    private val logger = LoggerFactory.getLogger(this.javaClass)

	@Autowired
	private lateinit var mapper : ${className}Mapper

	@GetMapping
	@ApiOperation(value = "${table.remark}列表", notes = "")
	@ApiImplicitParams(
		ApiImplicitParam(paramType = "query", name = "size", value = "分页大小", required = true, defaultValue = "20"),
		ApiImplicitParam(paramType = "query", name = "page", value = "分页页码（0开始）", defaultValue = "0"),
		ApiImplicitParam(paramType = "query", name = "skip", value = "分页开始（0开始）", defaultValue = "0")
	)
	fun list(@ApiIgnore paging: Paging): ApiResult<Paged<${className}>> {
		val count = mapper.countAll()
		val list = mapper.findByPage("", paging.count(), paging.start())
		return ApiResult(result = Paged(paging, list, count))
    }

    @PostMapping
    @ApiOperation(value = "添加${table.remark}", notes = "")
    @ApiImplicitParams(
		<#list table.columns as column>
		<#if column.name!=table.idColumn.name>
		ApiImplicitParam(paramType = "form", name = "${column.fieldName}", value = "${column.remark}", dataType = "${column.fieldType}" <#if column.nullable!=true>, required = true</#if><#if column.defValue??>, defaultValue = "${column.defValue}"</#if>)<#if column_has_next>,</#if>
		</#if>
		</#list>
    )
    fun insert(@Validated @ApiIgnore model: ${className}): ApiResult<Boolean> {
        mapper.insert(model)
        return ApiResult(true)
	}


	@PutMapping
	@ApiOperation(value = "更新${table.remark}", notes = "")
	@ApiImplicitParams(
	<#list table.columns as column>
		ApiImplicitParam(paramType = "form", name = "${column.fieldName}", value = "${column.remark}", dataType = "${column.fieldType}" <#if column.nullable!=true>, required = true</#if><#if column.defValue??>, defaultValue = "${column.defValue}"</#if>)<#if column_has_next>,</#if>
	</#list>
	)
	fun update(@Validated @ApiIgnore model: ${className}): ApiResult<Int> {
		return ApiResult(mapper.update(model))
	}


	@ApiOperation(value = "获取${table.remark}", notes = "")
	@GetMapping("/{id}")
	fun get(@PathVariable @ApiParam("${table.remark}Id") id: String): ApiResult<${className}> {
		return ApiResult.success(mapper.findById(id))
	}

	@ApiOperation(value = "删除${table.remark}", notes = "")
	@DeleteMapping("/{id}")
	fun delete(@PathVariable @ApiParam("${table.remark}Id") id: String): ApiResult<Int> {
		return ApiResult.success(mapper.delete(id))
	}

}
