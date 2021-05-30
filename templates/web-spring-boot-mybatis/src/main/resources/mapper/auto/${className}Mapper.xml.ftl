<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${packageName}.mapper.auto.${className}AutoMapper">
    <!--${table.remark} 的 Mapper 实现 -->
    <#list table.descriptions as description>
    <!--${description} -->
    </#list>
    <resultMap id="MAP" type="${packageName}.model.db.${className}">
        <!--${table.idColumn.remark}-->
        <id column="${table.idColumn.name}" jdbcType="${table.idColumn.typeJdbc}" property="${table.idColumn.fieldName}" />
<#list table.columns as column>
    <#if column != table.idColumn>
        <!--${column.remark?replace("-","~")}-->
        <result column="${column.name}" jdbcType="${column.typeJdbc}" property="${column.fieldName}" />
    </#if>
</#list>
    </resultMap>
<#if table.hasCascadeKey>

    <!-- 数据映射（包含外键）-->
    <resultMap id="MAP-INFO" type="${packageName}.model.db.${className}Bean" extends="MAP">
    <#list table.importCascadeKeys as key>
        <association column="{${key.pkColumn.fieldName}=${key.fkColumn.name}}" property="${tools.idToModel(key.fkColumn.fieldName)}" select="${packageName}.mapper.auto.${key.pkTable.className}AutoMapper.findById" />
    </#list>
    <#list table.exportCascadeKeys as key>
        <collection column="{${key.fkColumn.fieldName}=${key.pkColumn.fieldName}}" property="${tools.toPlural(key.fkTable.classNameCamel)}" select="${packageName}.mapper.auto.${key.fkTable.className}AutoMapper.selectBy${key.fkColumn.fieldNameUpper}"/>
    </#list>
    <#list table.relateCascadeKeys as key>
        <collection column="{${key.relateLocalColumn.fieldName}=${key.localColumn.fieldName}}" property="related${tools.toPlural(key.targetTable.className)}" select="${packageName}.mapper.auto.${key.targetTable.className}AutoMapper.selectByRelate${key.relateLocalColumn.fieldNameUpper}"/>
    </#list>
    </resultMap>
</#if>

    <!-- 插入新数据（非空插入，不支持批量插入）-->
    <insert id="insert" parameterType="${packageName}.model.db.${className}" <#if table.idColumn.autoIncrement>useGeneratedKeys="true" keyProperty="${table.idColumn.fieldName}"</#if>>
        INSERT INTO ${table.nameSql} (
        <trim suffixOverrides=",">
        <#list table.columns as column>
            <#if column.autoIncrement>
            <if test="${column.fieldName} != 0">
                ${column.nameSql},
            </if>
            <#else >
            <if test="${column.fieldName} != null">
                ${column.nameSql},
            </if>
            </#if>
        </#list>
        </trim>
        ) VALUES (
        <trim suffixOverrides=",">
        <#list table.columns as column>
            <#if column.autoIncrement>
            <if test="${column.fieldName} != 0">
                ${r"#"}{${column.fieldName}},
            </if>
            <#else >
            <if test="${column.fieldName} != null">
                ${r"#"}{${column.fieldName}},
            </if>
            </#if>
        </#list>
        </trim>
        )
    </insert>

    <!-- 插入新数据（全插入，支持批量插入）-->
<#if (dbType!"")=="oracle">
    <insert id="insertFull" parameterType="${packageName}.model.db.${className}" <#if table.idColumn.autoIncrement>useGeneratedKeys="true" keyProperty="${table.idColumn.fieldName}"</#if>>
        INSERT ALL
        <foreach item="model" collection="models">
            INTO ${table.nameSql}
            (<#list table.columns as column>${column.nameSql}<#if column_has_next>,</#if></#list>)
            VALUES
            (<#list table.columns as column>${r"#"}{model.${column.fieldName}}<#if column_has_next>,</#if></#list>)
        </foreach>
        SELECT 1 FROM DUAL
    </insert>
<#else >
    <insert id="insertFull" parameterType="${packageName}.model.db.${className}" <#if table.idColumn.autoIncrement>useGeneratedKeys="true" keyProperty="${table.idColumn.fieldName}"</#if>>
        INSERT INTO ${table.nameSql}
        (<#list table.columns as column>${column.nameSql}<#if column_has_next>,</#if></#list>)
        VALUES
        <foreach item="model" collection="models" separator=",">
            (<#list table.columns as column>${r"#"}{model.${column.fieldName}}<#if column_has_next>,</#if></#list>)
        </foreach>
    </insert>
</#if>

    <!-- 更新一条数据（非空更新）-->
    <update id="update" parameterType="${packageName}.model.db.${className}">
        UPDATE ${table.nameSql}
        <set>
        <#list table.columns as column>
            <#if column != table.idColumn && column != table.orgColumn>
            <if test="${column.fieldName} != null">
                ${column.nameSql}=${r"#"}{${column.fieldName}},
            </if>
            </#if>
        </#list>
        </set>
        WHERE ${table.idColumn.nameSql}=${r"#"}{${table.idColumn.fieldName}}
    </update>

    <!-- 更新一条数据（全更新）-->
    <update id="updateFull" parameterType="${packageName}.model.db.${className}">
        UPDATE ${table.nameSql}
        <set>
        <#list table.columns as column>
            <#if column != table.idColumn>
            ${column.nameSql}=${r"#"}{${column.fieldName}},
            </#if>
        </#list>
        </set>
        WHERE ${table.idColumn.nameSql}=${r"#"}{${table.idColumn.fieldName}}
    </update>

    <!-- 更新数据（灵活构建查询条件，修改多条）-->
    <update id="updateSetter">
        <if test="column != null or wheres != null">
          UPDATE ${table.nameSql}
          <set>
              <foreach collection="setmap" index="key" item="value" separator=",">
                  ${r"$"}{key} = ${r"#"}{value}
              </foreach>
          </set>
          WHERE
          <include refid="include.sql_where_internal"/>
        </if>
    </update>

<#if table.hasId>
    <!-- 根据ID删除（支持批量删除）-->
    <delete id="deleteById">
        DELETE FROM ${table.nameSql} WHERE ${table.idColumn.nameSql} IN
        <foreach collection="ids" item="id" open="(" close=")" separator=",">
            ${r"#"}{id}
        </foreach>
    </delete>

</#if>
    <!-- 根据条件删除（灵活构建查询条件） -->
    <delete id="deleteWhere">
        DELETE FROM ${table.nameSql} WHERE
        <include refid="include.sql_where_internal"/>
    </delete>

    <!-- 统计数据数量（全部） -->
    <select id="countAll" resultType="java.lang.Integer">
        SELECT COUNT(0) FROM ${table.nameSql}
    </select>

    <!-- 根据条件统计数据数量（灵活构建查询条件） -->
    <select id="countWhere" resultType="java.lang.Integer">
        SELECT COUNT(0) FROM ${table.nameSql}
        <include refid="include.sql_where"/>
    </select>

<#if table.hasId>
    <!-- 根据ID获取 -->
    <select id="findById" resultMap="MAP">
        SELECT * FROM ${table.nameSql} WHERE ${table.idColumn.nameSql}=${r"#"}{id}
    </select>

</#if>
    <!-- 单条查询（灵活构建查询条件） -->
    <select id="selectOneWhere" resultMap="MAP">
        SELECT * FROM ${table.nameSql}
        <include refid="include.sql_where"/>
        <include refid="include.sql_order">
            <property name="defaultOrder" value="<#if table.hasCode>ORDER BY ${table.codeColumn.nameSql}</#if>"/>
        </include>
    </select>

    <!-- 批量查询（灵活构建查询条件） -->
    <select id="selectWhere" resultMap="MAP">
        SELECT * FROM ${table.nameSql}
        <include refid="include.sql_where"/>
        <include refid="include.sql_order">
            <property name="defaultOrder" value="<#if table.hasCode>ORDER BY ${table.codeColumn.nameSql}</#if>"/>
        </include>
    </select>
<#if table.hasCascadeKey>
    <#if table.hasId>

    <!-- 根据ID获取（包含外键） -->
    <select id="findBeanById" resultMap="MAP-INFO">
        SELECT * FROM ${table.nameSql} WHERE ${table.idColumn.nameSql}=${r"#"}{id}
    </select>
    </#if>

    <!-- 单条查询（包含外键，灵活构建查询条件） -->
    <select id="selectBeanOneWhere" resultMap="MAP-INFO">
        SELECT * FROM ${table.nameSql}
        <include refid="include.sql_where"/>
        <include refid="include.sql_order">
            <property name="defaultOrder" value="<#if table.hasCode>ORDER BY ${table.codeColumn.nameSql}</#if>"/>
        </include>
    </select>

    <!-- 批量查询（包含外键，灵活构建查询条件） -->
    <select id="selectBeanWhere" resultMap="MAP-INFO">
        SELECT * FROM ${table.nameSql}
        <include refid="include.sql_where"/>
        <include refid="include.sql_order">
            <property name="defaultOrder" value="<#if table.hasCode>ORDER BY ${table.codeColumn.nameSql}</#if>"/>
        </include>
    </select>
</#if>
<#list table.importedKeys as key>

    <!-- 批量查询（根据${key.pkTable.remarkName}）-->
    <select id="selectBy${key.fkColumn.fieldNameUpper}" resultMap="MAP">
        SELECT * FROM ${table.nameSql} WHERE ${key.fkColumn.nameSql}=${r"#"}{${key.fkColumn.fieldName}}<#if table.hasCode> ORDER BY ${table.codeColumn.nameSql} </#if>
    </select>
</#list>
<#list table.relateCascadeKeys as key>

    <!-- 级联查询（根据${key.targetTable.remarkName}${key.targetColumn.remarkName}）-->
    <select id="selectByRelate${key.relateTargetColumn.fieldNameUpper}" resultMap="MAP">
        SELECT * FROM ${table.nameSql} WHERE ${key.localColumn.nameSql} IN (SELECT ${key.relateLocalColumn.nameSql} FROM ${key.relateTable.nameSql} WHERE ${key.relateTargetColumn.nameSql}=${r"#"}{${key.relateTargetColumn.fieldName}})
    </select>
</#list>

</mapper>

