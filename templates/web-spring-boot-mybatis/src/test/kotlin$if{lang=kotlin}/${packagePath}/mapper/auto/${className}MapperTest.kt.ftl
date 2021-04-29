package ${packageName}.mapper.auto

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
import ${packageName}.mapper.BaseMapperTests
import ${packageName}.mapper.intent.Tables
import ${packageName}.model.db.${className}
<#if table.idColumn.stringType>
import ${packageName}.util.ID22
</#if>
import org.apache.ibatis.session.RowBounds

import org.junit.jupiter.api.Disabled
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import org.springframework.beans.factory.annotation.Autowired

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
class ${className}MapperTest : BaseMapperTests<${className}>() {

    @Autowired
    protected lateinit var mapper: ${className}Mapper

	private fun newModel(index: Int): ${className} {
		val model = ${className}()
<#if table.idColumn.stringType>
        model.${table.idColumn.fieldName} = ID22.random()<#if table.idColumn.length < 22>.substring(0, ${table.idColumn.length})</#if>
</#if>
<#list table.columns as column>
    <#if column.stringType && column != table.idColumn>
        model.${column.fieldName} = buildInsertString(index, ${column.length?c})
    <#elseif column.fieldType == "java.util.Date" && column != table.idColumn>
        model.${column.fieldName} = java.util.Date()
    <#elseif column.nullable != true && column != table.idColumn>
        //生成器无法构建必须字段来测试 ${column.fieldType} ${column.fieldName} ${column.remark!""} ${(column.description!"")?replace("\n","\\n")}
        //model.${column.fieldName} = [无法构建]
    </#if>
</#list>
		return model
	}

    /**
     * 完整测试
     * 添加、查询、更新、删除
     */
	@Test
    @Disabled
    @DisplayName("增删改查全测试")
	fun testFull() {
<#if find1>
        //删除之前的测试数据
        val row = mapper.deleteWhere(Tables.${table.className}.${column1.fieldNameUpper}.contains(strInsert))
        println("删除之前的测试数据" + row + "条")

        //添加测试开始
    <#if table.idColumn.stringType>
        var find: ${className}? = null
        val model = newModel(1)
        mapper.insert(model)
        mapper.insertFull(newModel(2), newModel(3))

        find = mapper.findById(model.${table.idColumn.fieldName})
        assert(find != null && model.${table.idColumn.fieldName}.equals(find.${table.idColumn.fieldName}))

        find = mapper.selectOneWhere(Tables.${table.className}.${table.idColumn.fieldNameUpper}.eq(model.${table.idColumn.fieldName}))
        assert(find != null && model.${table.idColumn.fieldName}.equals(find.${table.idColumn.fieldName}))

    <#else>
        mapper.insert(newModel(1))
        mapper.insertFull(newModel(2), newModel(3))

    </#if>
        //列表查询测试开始
        val models1 = mapper.selectWhere(Tables.${table.className}.${column1.fieldNameUpper}.startsWith(strInsert + 1))
        val models2 = mapper.selectWhere(Tables.${table.className}.${column1.fieldNameUpper}.contains(strInsert + 2), RowBounds(0, 1))

        println("列表查询测试1结果：" + json.writerWithDefaultPrettyPrinter().writeValueAsString(models1))
        println("列表查询测试2结果：" + json.writerWithDefaultPrettyPrinter().writeValueAsString(models2))

        assert(models1.isNotEmpty())
        assert(models2.size == 1)

        //数量统计测试开始
        val count1 = mapper.countAll()
        val count2 = mapper.countWhere(Tables.${table.className}.${column1.fieldNameUpper}.eq(strInsert + 1))

        println("数量统计测试结果：count1 = $count1 count2 = $count2")

        assert(count1 > 0)
        assert(count2 > 0)
        assert(count1 >= count2)

    <#if find2>
        // 单条更新测试开始
        models1[0].${column2.fieldName} = strUpdate + 1
        val updateRow1 = mapper.update(models1[0])
        val updateRow2 = mapper.updateSetter(Tables.${table.className}.set${column2.fieldNameUpper}(strUpdate + 2).where(Tables.${table.className}.${table.idColumn.fieldNameUpper}.eq(models2[0].${table.idColumn.fieldName})))

        println("单条更新测试结果：updateRow1 = $updateRow1 updateRow2 = $updateRow2")

        assert(updateRow1 == 1)
        assert(updateRow2 == 1)

        //单条查询测试开始
        val model1 = mapper.findById(models1[0].${table.idColumn.fieldName}) ?: throw RuntimeException("插入测试获取失败")
        val model2 = mapper.selectOneWhere(Tables.${table.className}.${table.idColumn.fieldNameUpper}.eq(models2[0].${table.idColumn.fieldName})) ?: throw RuntimeException("插入测试获取失败")

        println("单条查询测试结果：" + json.writerWithDefaultPrettyPrinter().writeValueAsString(listOf(model1, model2)))

        assert(strUpdate + 1 == model1.${column2.fieldName})
        assert(strUpdate + 2 == model2.${column2.fieldName})
    </#if>

        //单条删除测试开始
        val delRow1 = mapper.deleteById(models1[0].${table.idColumn.fieldName})
        val delRow2 = mapper.deleteWhere(Tables.${table.className}.${column1.fieldNameUpper}.inList(listOf(strInsert + 2, strInsert + 3)))

        println("单条删除测试结果：delRow1 = $delRow1 delRow2 = $delRow2")

        assert(delRow1 == 1)
        assert(delRow2 > 0)
</#if>
	}

}
