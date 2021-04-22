package ${packageName}.mapper.auto;

<#assign find1=false>
<#assign find2=false>
<#assign column1='null'>
<#assign column2='null'>
<#list table.columns as column>
    <#if (column != table.idColumn && column.stringType && column.length > 6 && !find2 && find1) >
        <#assign find2=true>
        <#assign column2=column>
    </#if>
    <#if (column != table.idColumn && column.stringType && column.length > 6 && !find1) >
        <#assign find1=true>
        <#assign column1=column>
    </#if>
</#list>
import com.fasterxml.jackson.core.JsonProcessingException;
import ${packageName}.mapper.BaseMapperTests;
import ${packageName}.mapper.intent.Tables;
import ${packageName}.model.db.${className};
<#if table.idColumn.stringType>
import ${packageName}.util.ID22;
</#if>
import org.apache.ibatis.session.RowBounds;

import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import org.springframework.beans.factory.annotation.Autowired;

<#if find1>
import java.util.Arrays;
</#if>
import java.util.List;

/**
 * ${table.remark} 的 Mapper 单元测试
<#list table.descriptions as description>
 * ${description}
</#list>
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Disabled
@DisplayName("【${table.remarkName}】的Mapper层测试类")
public class ${className}MapperTest extends BaseMapperTests<${className}> {

    @Autowired
    protected ${className}Mapper mapper;

	private ${className} newModel(int index) {
		${className} model = new ${className}();
<#if table.idColumn.stringType>
        model.set${table.idColumn.fieldNameUpper}(ID22.random()<#if table.idColumn.length < 22>.substring(0, ${table.idColumn.length})</#if>);
</#if>
<#list table.columns as column>
    <#if column.stringType && column != table.idColumn>
        model.set${column.fieldNameUpper}(buildInsertString(index, ${column.length?c}));
    <#elseif column.fieldType == "java.util.Date" && column != table.idColumn>
        model.set${column.fieldNameUpper}(new java.util.Date());
    <#elseif column.nullable != true && column != table.idColumn>
        //生成器无法构建必须字段来测试 ${column.fieldType} ${column.fieldName} ${column.remark!""} ${(column.description!"")?replace("\n","\\n")}
        //model.set${column.fieldNameUpper}(无法构建);
    </#if>
</#list>
		return model;
	}

    /**
     * 完整测试
     * 添加、查询、更新、删除
     * @throws JsonProcessingException JSON 解析异常
     */
	@Test
    @Disabled
    @DisplayName("增删改查全测试")
	public void testFull() throws JsonProcessingException {
<#if find1>
        //删除之前的测试数据
        int row = mapper.deleteWhere(Tables.${table.className}.${column1.fieldNameUpper}.like(strInsert + "%"));//("${column1.nameSqlInStr} LIKE '" + strInsert + "%'");
        System.out.println("删除之前的测试数据" + row + "条");

        //添加测试开始
    <#if table.idColumn.stringType>
        ${className} find,model = newModel(1);
        mapper.insert(model);
        mapper.insertFull(newModel(2), newModel(3));

        find = mapper.findById(model.get${table.idColumn.fieldNameUpper}());
        assert find != null && model.get${table.idColumn.fieldNameUpper}().equals(find.get${table.idColumn.fieldNameUpper}());

        find = mapper.selectOneWhere(Tables.${table.className}.${table.idColumn.fieldNameUpper}.eq(model.get${table.idColumn.fieldNameUpper}()));
        assert find != null && model.get${table.idColumn.fieldNameUpper}().equals(find.get${table.idColumn.fieldNameUpper}());

    <#else>
        mapper.insert(newModel(1));
        mapper.insertFull(newModel(2), newModel(3));

    </#if>
        //列表查询测试开始
        List<${className}> models1 = mapper.selectWhere(Tables.${table.className}.${column1.fieldNameUpper}.eq(strInsert + 2));
        List<${className}> models2 = mapper.selectWhere(Tables.${table.className}.${column1.fieldNameUpper}.eq(strInsert + 2), new RowBounds(0, 1));

        System.out.println("列表查询测试1结果：" + json.writerWithDefaultPrettyPrinter().writeValueAsString(models1));
        System.out.println("列表查询测试2结果：" + json.writerWithDefaultPrettyPrinter().writeValueAsString(models2));

        assert models1.size() > 0;
        assert models2.size() == 1;

        //数量统计测试开始
        int count1 = mapper.countAll();
        int count2 = mapper.countWhere(Tables.${table.className}.${column1.fieldNameUpper}.eq(strInsert + 1));

        System.out.println("数量统计测试结果：count1 = " + count1 + " count2 = " + count2);

        assert count1 > 0;
        assert count2 > 0;
        assert count1 >= count2;

    <#if find2>
        // 单条更新测试开始
        models1.get(0).set${column2.fieldNameUpper}(strUpdate);
        int updateRow1 = mapper.update(models1.get(0));
        int updateRow2 = mapper.updateSetter(Tables.${table.className}.set${column2.fieldNameUpper}(strUpdate).where(Tables.${table.className}.${table.idColumn.fieldNameUpper}.eq(models2.get(0).get${table.idColumn.fieldNameUpper}())));

        System.out.println("单条更新测试结果：updateRow1 = " + updateRow1 + " updateRow2 = " + updateRow2);

        //单条查询测试开始
        ${className} model1 = mapper.findById(models1.get(0).get${table.idColumn.fieldNameUpper}());
        ${className} model2 = mapper.selectOneWhere(Tables.${table.className}.${table.idColumn.fieldNameUpper}.eq(models2.get(0).get${table.idColumn.fieldNameUpper}()));

        System.out.println("单条查询测试结果：" + json.writerWithDefaultPrettyPrinter().writeValueAsString(Arrays.asList(model1, model2)));

        assert strUpdate.equals(model1.get${column2.fieldNameUpper}());
        assert strUpdate.equals(model2.get${column2.fieldNameUpper}());
    </#if>

        //单条删除测试开始
        int delRow1 = mapper.deleteById(models1.get(0).get${table.idColumn.fieldNameUpper}());
        int delRow2 = mapper.deleteWhere(Tables.${table.className}.${column1.fieldNameUpper}.eq(strInsert + 2));

        System.out.println("单条删除测试结果：delRow1 = " + delRow1 + " delRow2 = " + delRow2);

        assert delRow1 == 1;
        assert delRow2 > 0;
</#if>
	}

}
