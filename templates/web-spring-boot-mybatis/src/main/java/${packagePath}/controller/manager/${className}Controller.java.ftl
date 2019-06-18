package ${packageName}.controller.manager;

import ${packageName}.mapper.common.${className}Mapper;
import ${packageName}.model.api.ApiResult;
import ${packageName}.model.api.Paged;
import ${packageName}.model.api.Paging;
import ${packageName}.model.db.${className};
import ${packageName}.util.ID22;
import io.swagger.annotations.*;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import springfox.documentation.annotations.ApiIgnore;
import java.util.*;

/**
 * ${table.remark} 的 Controller 层实现
 * @author ${author}
 * @since ${.now?string("yyyy-MM-dd zzzz")}
 */
@RestController
@Api(value = "${table.urlPathName}", description = "${table.remark}API")
@RequestMapping("/api/v1/${table.urlPathName}")
public class ${className}Controller {

//    private Logger logger = LoggerFactory.getLogger(this.getClass());

	private final ${className}Mapper mapper;

	public ${className}Controller(${className}Mapper mapper) {
		this.mapper = mapper;
	}

	@GetMapping
	@ApiOperation(value = "${table.remark}列表")
	@ApiImplicitParams({
		@ApiImplicitParam(paramType = "query", name = "size", value = "分页大小", required = true, defaultValue = "20"),
		@ApiImplicitParam(paramType = "query", name = "page", value = "分页页码（0开始）", defaultValue = "0"),
		@ApiImplicitParam(paramType = "query", name = "skip", value = "分页开始（0开始）", defaultValue = "0")
	})
    public ApiResult<Paged<${className}>> list(@ApiIgnore Paging paging) {
		int count = mapper.countAll();
		List<${className}> list = mapper.findByPage("", paging.count(), paging.start());
		return ApiResult.success(new Paged<>(paging, list, count));
    }

    @PostMapping
    @ApiOperation(value = "添加${table.remark}")
    @ApiImplicitParams({
		<#list table.columns as column>
		<#if column.name!=table.idColumn.name>
		@ApiImplicitParam(paramType = "form", name = "${column.fieldName}", value = "${column.remark}", dataType = "${column.fieldType}" <#if column.nullable!=true>, required = true</#if><#if column.defValue?length != 0>, defaultValue = "${column.defValue}"</#if>)<#if column_has_next>,</#if>
		</#if>
		</#list>
    })
	<#if !table.idColumn.autoIncrement && table.idColumn.typeJdbc?contains('CHAR')>
	public ApiResult<String> insert(@Validated @ApiIgnore ${className} model) {
		if(model.get${table.idColumn.fieldNameUpper}() == null) {
			model.set${table.idColumn.fieldNameUpper}(ID22.randomID22());
		}
	<#else>
	public ApiResult<Boolean> insert(@Validated @ApiIgnore ${className} model) {
	</#if>
	<#list table.columns as column>
		<#if column.name == 'create_time'>
		model.set${column.fieldNameUpper}(new Date());
		<#elseif column.name == 'update_time'>
		model.set${column.fieldNameUpper}(new Date());
		</#if>
	</#list>
        mapper.insert(model);
	<#if !table.idColumn.autoIncrement && table.idColumn.typeJdbc?contains('CHAR')>
		return ApiResult.success(model.get${table.idColumn.fieldNameUpper}());
	<#else>
		return ApiResult.success(true);
	</#if>
	}


	@PutMapping
	@ApiOperation(value = "更新${table.remark}")
	@ApiImplicitParams({
	<#list table.columns as column>
		@ApiImplicitParam(paramType = "form", name = "${column.fieldName}", value = "${column.remark}", dataType = "${column.fieldType}" <#if column.nullable!=true>, required = true</#if><#if column.defValue?length != 0>, defaultValue = "${column.defValue}"</#if>)<#if column_has_next>,</#if>
	</#list>
	})
    public ApiResult<Integer> update(@Validated @ApiIgnore ${className} model) {
		<#list table.columns as column>
			<#if column.name == 'update_time'>
		model.set${column.fieldNameUpper}(new Date());
			</#if>
		</#list>
		return ApiResult.success(mapper.update(model));
	}


	@ApiOperation(value = "获取${table.remark}")
	@GetMapping("/{id}")
    public ApiResult<${className}> get(@PathVariable @ApiParam("${table.remark}Id") String id) {
		return ApiResult.success(mapper.findById(id));
	}

	@ApiOperation(value = "删除${table.remark}")
	@DeleteMapping("/{id}")
    public ApiResult<Integer> delete(@PathVariable @ApiParam("${table.remark}Id") String id) {
		return ApiResult.success(mapper.delete(id));
	}

}
