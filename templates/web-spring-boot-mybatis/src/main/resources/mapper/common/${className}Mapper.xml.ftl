<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${packageName}.mapper.common.${className}Mapper">
  <!--${table.remark} 的 Mapper 实现 -->
  <#list table.descriptions as description>
  <!--${description} -->
  </#list>
  <resultMap id="MAP" type="${packageName}.model.db.${className}">
    <!--${table.idColumn.remark}-->
    <id column="${table.idColumn.name}" jdbcType="${table.idColumn.typeJdbc}" property="${table.idColumn.fieldName}" />
    <#list table.columns as column>
    <#if table.idColumn.name != column.name>
    <!--${column.remark?replace("-","~")}-->
    <result column="${column.name}" jdbcType="${column.typeJdbc}" property="${column.fieldName}" />
    </#if>
    </#list>
  </resultMap>
  
  <!-- 重用SQL WHERE -->
  <sql id="sqlWhere">
    <if test="where != null and where != ''">
      <where>
        ${r"$"}{where}
      </where>
    </if>
  </sql>
  
  <!-- 重用SQL WHERE ORDER-->
  <sql id="sqlWhereOrder">
    <include refid="sqlWhere">
      <property name="where" value="${r"$"}{where}"/>
    </include>
    <if test="order != null and order != ''">
      ORDER BY ${r"$"}{order}
    </if>
  </sql>
  
  <!-- 重用 Intent WHERE (AND OR) -->
  <sql id="intentWhere">
    <where>
      <foreach collection="andMap" index="key" item="value" separator=" AND ">
        ${r"$"}{key} = ${r"#"}{value}
      </foreach>
      <foreach collection="orMap" index="key" item="value" open=" AND (" separator=" OR " close=")">
        ${r"$"}{key} = ${r"#"}{value}
      </foreach>
    </where>
  </sql>

  <!-- 重用 Intent WHERE (AND OR) ORDER -->
  <sql id="intentWhereOrder">
    <include refid="intentWhere">
      <property name="orMap" value="${r"$"}{orMap}"/>
      <property name="andMap" value="${r"$"}{andMap}"/>
    </include>
    <if test="orderSet.size > 0">
      ORDER BY
      <foreach item="order" collection="orderSet" separator=",">
        ${r"$"}{order}
      </foreach>
    </if>
  </sql>

  <!-- 插入新数据（非空插入，不支持批量插入）-->
  <insert id="insert" parameterType="${packageName}.model.db.${className}" <#if table.idColumn.autoIncrement>useGeneratedKeys="true" keyProperty="${table.idColumn.fieldName}"</#if>>
    INSERT INTO ${table.nameSQL} (
    <trim suffixOverrides=",">
    <#list table.columns as column>
      <if test="${column.fieldName} != null">
        ${column.nameSQL},
      </if>
    </#list>
    </trim>
    ) VALUES (
    <trim suffixOverrides=",">
    <#list table.columns as column>
      <if test="${column.fieldName} != null">
        ${r"#"}{${column.fieldName}},
      </if>
    </#list>
    </trim>
    )
  </insert>

  <!-- 插入新数据（全插入，支持批量插入）-->
<#if (dbType!"")=="oracle">
  <insert id="insertFull" parameterType="${packageName}.model.db.${className}" <#if table.idColumn.autoIncrement>useGeneratedKeys="true" keyProperty="${table.idColumn.fieldName}"</#if>>
    INSERT ALL
    <foreach item="model" collection="models">
      INTO ${table.nameSQL}
      (<#list table.columns as column>${column.nameSQL}<#if column_has_next>,</#if></#list>)
      VALUES
      (<#list table.columns as column>${r"#"}{model.${column.fieldName}}<#if column_has_next>,</#if></#list>)
    </foreach>
    SELECT 1 FROM DUAL
  </insert>
<#else >
  <insert id="insertFull" parameterType="${packageName}.model.db.${className}" <#if table.idColumn.autoIncrement>useGeneratedKeys="true" keyProperty="${table.idColumn.fieldName}"</#if>>
    INSERT INTO ${table.nameSQL}
    (<#list table.columns as column>${column.nameSQL}<#if column_has_next>,</#if></#list>)
    VALUES
    <foreach item="model" collection="models" separator=",">
      (<#list table.columns as column>${r"#"}{model.${column.fieldName}}<#if column_has_next>,</#if></#list>)
    </foreach>
  </insert>
</#if>

  <!-- 更新一条数据（非空更新）-->
  <update id="update" parameterType="${packageName}.model.db.${className}">
    UPDATE ${table.nameSQL}
    <set>
      <#list table.columns as column>
        <#if column.name != table.idColumn.name>
      <if test="${column.fieldName} != null">
        ${column.nameSQL}=${r"#"}{${column.fieldName}},
      </if>
        </#if>
      </#list>
    </set>
    WHERE ${table.idColumn.nameSQL}=${r"#"}{${table.idColumn.fieldName}}
  </update>

  <!-- 更新一条数据（全更新）-->
  <update id="updateFull" parameterType="${packageName}.model.db.${className}">
    UPDATE ${table.nameSQL}
    <set>
      <#list table.columns as column>
        ${column.nameSQL}=${r"#"}{${column.fieldName}},
      </#list>
    </set>
    WHERE ${table.idColumn.nameSQL}=${r"#"}{${table.idColumn.fieldName}}
  </update>

  <!-- 更新一条数据（灵活构建意图）-->
  <update id="updateIntent">
    <if test="andMap.size > 0 or orMap.size > 0">
      UPDATE ${table.nameSQL}
      <set>
      <foreach collection="setMap" index="key" item="value" separator=",">
        ${r"$"}{key} = ${r"#"}{value}
      </foreach>
      </set>
      <include refid="intentWhere">
        <property name="orMap" value="${r"$"}{orMap}"/>
        <property name="andMap" value="${r"$"}{andMap}"/>
      </include>
    </if>
  </update>

  <!-- 根据ID删除（支持批量删除）-->
  <delete id="delete">
    DELETE FROM ${table.nameSQL} WHERE ${table.idColumn.nameSQL} IN
    <foreach collection="ids" item="id" open="(" close=")" separator=",">
        ${r"#"}{id}
    </foreach>
  </delete>

  <!-- 根据条件删除 -->
  <delete id="deleteWhere">
    <if test="where != null and where != ''">
      DELETE FROM ${table.nameSQL}
      <include refid="sqlWhere">
        <property name="where" value="${r"$"}{where}"/>
      </include>
    </if>
  </delete>

  <!-- 根据条件删除（灵活构建意图） -->
  <delete id="deleteIntent">
    <if test="andMap.keys.size > 0 or orMap.keys.size > 0">
    DELETE FROM ${table.nameSQL}
      <include refid="intentWhere">
        <property name="orMap" value="${r"$"}{orMap}"/>
        <property name="andMap" value="${r"$"}{andMap}"/>
      </include>
    </if>
  </delete>

  <!-- 统计数据数量（全部） -->
  <select id="countAll" resultType="java.lang.Integer">
    SELECT COUNT(0) FROM ${table.nameSQL}
  </select>

  <!-- 根据条件统计数据数量（Where 拼接） -->
  <select id="countWhere" resultType="java.lang.Integer">
    SELECT COUNT(0) FROM ${table.nameSQL}
    <include refid="sqlWhere">
      <property name="where" value="${r"$"}{where}"/>
    </include>
  </select>

  <!-- 根据条件统计数据数量（灵活构建意图） -->
  <select id="countIntent" resultType="java.lang.Integer">
    SELECT COUNT(0) FROM ${table.nameSQL}
    <include refid="intentWhere">
      <property name="orMap" value="${r"$"}{orMap}"/>
      <property name="andMap" value="${r"$"}{andMap}"/>
    </include>
  </select>

  <!-- 根据ID获取 -->
  <select id="findById" resultMap="MAP">
    SELECT * FROM ${table.nameSQL} WHERE ${table.idColumn.nameSQL}=${r"#"}{id}
  </select>

  <!-- 单条查询（Where 拼接 Order 拼接） -->
  <select id="findOneWhere" resultMap="MAP">
    SELECT * FROM ${table.nameSQL}
    <include refid="sqlWhereOrder">
      <property name="where" value="${r"$"}{where}"/>
      <property name="order" value="${r"$"}{order}"/>
    </include>
  </select>

  <!-- 单条查询（灵活构建意图） -->
  <select id="findOneIntent" resultMap="MAP">
    SELECT * FROM ${table.nameSQL}
    <include refid="intentWhereOrder">
      <property name="orMap" value="${r"$"}{orMap}"/>
      <property name="andMap" value="${r"$"}{andMap}"/>
      <property name="orderSet" value="${r"$"}{orderSet}"/>
    </include>
  </select>

  <!-- 批量查询（Where 拼接 Order 拼接） -->
  <select id="findListWhere" resultMap="MAP">
    SELECT * FROM ${table.nameSQL}
    <include refid="sqlWhereOrder">
      <property name="where" value="${r"$"}{where}"/>
      <property name="order" value="${r"$"}{order}"/>
    </include>
  </select>

  <!-- 批量查询（灵活构建意图） -->
  <select id="findListIntent" resultMap="MAP">
    SELECT * FROM ${table.nameSQL}
    <include refid="intentWhereOrder">
      <property name="orMap" value="${r"$"}{orMap}"/>
      <property name="andMap" value="${r"$"}{andMap}"/>
      <property name="orderSet" value="${r"$"}{orderSet}"/>
    </include>
  </select>

</mapper>

