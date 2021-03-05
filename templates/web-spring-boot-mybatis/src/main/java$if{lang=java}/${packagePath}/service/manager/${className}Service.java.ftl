package ${packageName}.service.manager;

import com.github.pagehelper.PageRowBounds;
import ${packageName}.mapper.common.${className}Mapper;
import ${packageName}.model.api.ApiResult;
import ${packageName}.model.api.Paged;
import ${packageName}.model.api.Paging;
import ${packageName}.model.db.${className};
<#if !table.idColumn.autoIncrement && table.idColumn.stringType>
import ${packageName}.util.ID22;
</#if>
import ${packageName}.util.SqlIntent;

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
@Service
public class ${className}Service {

//    private Logger logger = LoggerFactory.getLogger(this.getClass());

	private final ${className}Mapper mapper;

	public ${className}Service(${className}Mapper mapper) {
		this.mapper = mapper;
	}

	/**
	 * ${table.remark}列表
	 * @param paging 分页对象
	 */
    public Paged<${className}> list(Paging paging) {
		int count = mapper.countAll();
		List<${className}> list = mapper.findListIntent(SqlIntent.New(), new PageRowBounds(paging.start(), paging.count()));
		return new Paged<>(paging, list);
    }

	/**
	 * 添加${table.remark}
	 * @param model 实体对象
	<#if !table.idColumn.autoIncrement && table.idColumn.isStringType()>
	 × @return 返回新数据的Id
	 */
	public String insert(${className} model) {
		if(model.get${table.idColumn.fieldNameUpper}() == null) {
			model.set${table.idColumn.fieldNameUpper}(ID22.random());
		}
	<#else>
	 × @return 返回是否成功
	 */
	public boolean insert(${className} model) {
	</#if>
	<#list table.columns as column>
		<#if column.fieldType == 'java.util.Date' && (column.name?lower_case == 'create_time' || column.name?lower_case == 'create_date')>
		model.set${column.fieldNameUpper}(new java.util.Date());
		</#if>
	</#list>
        mapper.insert(model);
	<#if !table.idColumn.autoIncrement && table.idColumn.isStringType()>
		return model.get${table.idColumn.fieldNameUpper}();
	<#else>
		return true;
	</#if>
	}

	/**
	 * 更新${table.remark}
	 * @param model 实体对象
	 × @return 返回数据修改的行数
	 */
    public int update(${className} model) {
		<#list table.columns as column>
			<#if column.fieldType == 'java.util.Date' && (column.name?lower_case == 'update_time' || column.name?lower_case == 'update_date')>
		model.set${column.fieldNameUpper}(new java.util.Date());
			</#if>
		</#list>
		return mapper.update(model);
	}

	///**
	// * 获取${table.remark}
	// * @param id 数据主键
	// × @return 数据实体对象
	// */
    //public ${className} get(String id) {
	//	return mapper.findById(id);
	//}

	///**
	// * 获取${table.remark}
	// * @param id 数据主键
	// × @return 返回数据修改的行数
	// */
    //public int delete(String id) {
	//	return mapper.delete(id);
	//}

}
