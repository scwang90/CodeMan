package ${packageName}.service.auto;

import com.github.pagehelper.PageRowBounds;
import ${packageName}.mapper.auto.${className}Mapper;
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
@Service("auto${className}Service")
public class ${className}Service {

//    private Logger logger = LoggerFactory.getLogger(this.getClass());

	private final ${className}Mapper mapper;

	public ${className}Service(${className}Mapper mapper) {
		this.mapper = mapper;
	}

	/**
	 * ${table.remarkName}列表
	 * @param paging 分页对象
	 */
    public Paged<${className}> list(Paging paging) {
		List<${className}> list = mapper.findListIntent(SqlIntent.New(), new PageRowBounds(paging.start(), paging.count()));
		return new Paged<>(paging, list);
    }

	/**
	 * 添加${table.remarkName}
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
		<#if column == table.updateColumn || column == table.createColumn>
			<#if column.fieldType == 'long'>
		model.set${column.fieldNameUpper}(System.currentTimeMillis());
			<#elseif column.fieldType == 'java.util.Date'>
		model.set${column.fieldNameUpper}(new java.util.Date());
			</#if>
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

	///**
	// * 获取${table.remarkName}
	// * @param id 数据主键
	// × @return 数据实体对象
	// */
    //public ${className} get(String id) {
	//	return mapper.findById(id);
	//}

	///**
	// * 获取${table.remarkName}
	// * @param id 数据主键
	// × @return 返回数据修改的行数
	// */
    //public int delete(String id) {
	//	return mapper.delete(id);
	//}

}
