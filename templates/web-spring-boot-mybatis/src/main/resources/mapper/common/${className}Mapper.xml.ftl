<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${packageName}.mapper.common.${className}Mapper">
  <resultMap id="${table.className}" type="${packageName}.model.db.${className}">
    <!--${table.idColumn.remark}-->
    <id column="${table.idColumn.nameSQL}" jdbcType="${table.idColumn.typeJdbc}" property="${table.idColumn.fieldName}" />
    <#list table.columns as column>
    <#if table.idColumn.name != column.name>
    <!--${column.remark?replace("-","~")}-->
    <result column="${column.nameSQL}" jdbcType="${column.typeJdbc}" property="${column.fieldName}" />
    </#if>
    </#list>
  </resultMap>

  <!-- 重用SQL Where AND OR -->
  <sql id="whereIntent">
    <where>
      <foreach collection="andMap" index="key" item="value" separator=" AND ">
        ${r"$"}{key} = ${r"#"}{value}
      </foreach>
      <foreach collection="orMap" index="key" item="value" open=" AND (" separator=" OR " close=")">
        ${r"$"}{key} = ${r"#"}{value}
      </foreach>
    </where>
  </sql>

  <!-- 重用SQL Where AND OR ORDER -->
  <sql id="whereIntentOrder">
    <include refid="whereIntent">
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
    INSERT INTO ${table.name} (
    <#list table.columns as column>
      <if test="${column.fieldName} != null">
        ${column.nameSQL}<#if column_has_next>,</#if>
      </if>
    </#list>
    ) VALUES (
    <#list table.columns as column>
      <if test="${column.fieldName} != null">
        ${r"#"}{${column.fieldName}},
      </if>
    </#list>
    )
  </insert>

  <!-- 插入新数据（全插入，支持批量插入）-->
  <insert id="insertFull" parameterType="${packageName}.model.db.${className}" <#if table.idColumn.autoIncrement>useGeneratedKeys="true" keyProperty="${table.idColumn.fieldName}"</#if>>
    INSERT INTO ${table.name}
    (<#list table.columns as column>${column.nameSQL}<#if column_has_next>,</#if></#list>)
    VALUES
    <foreach item="model" collection="models" separator=",">
      (<#list table.columns as column>${r"#"}{${column.fieldName}}<#if column_has_next>,</#if></#list>)
    </foreach>
  </insert>

  <!-- 更新一条数据（非空更新）-->
  <update id="update" parameterType="${packageName}.model.db.${className}">
    UPDATE ${table.name}
    <set>
      <#list table.columns as column>
        <if test="${column.fieldName} != null">
          ${column.nameSQL}=${r"#"}{${column.fieldName}},
        </if>
      </#list>
    </set>
    WHERE ${table.idColumn.nameSQL}=${r"#"}{${table.idColumn.fieldName}
  </update>

  <!-- 更新一条数据（全更新）-->
  <update id="updateFull" parameterType="${packageName}.model.db.${className}">
    UPDATE ${table.name}
    <set>
      <#list table.columns as column>
        ${column.nameSQL}=${r"#"}{${column.fieldName}},
      </#list>
    </set>
    WHERE ${table.idColumn.nameSQL}=${r"#"}{${table.idColumn.fieldName}
  </update>

  <!-- 更新一条数据（灵活构建意图）-->
  <update id="updateIntent">
    UPDATE ${table.name}
    <set>
      <foreach collection="setMap" index="key" item="value" separator=",">
        ${r"$"}{key} = ${r"#"}{value}
      </foreach>
    </set>
    WHERE ${table.idColumn.nameSQL}=${r"#"}{id}
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
    <if test="where ！= null and where != ''">
    DELETE FROM ${table.nameSQL} ${r"${where}"}
    </if>
  </delete>

  <!-- 根据条件删除（灵活构建意图） -->
  <delete id="deleteIntent">
    <if test="andMap.keys.size > 0 or orMap.keys.size > 0">
    DELETE FROM ${table.nameSQL}
      <include refid="whereIntent">
        <property name="orMap" value="${r"$"}{orMap}"/>
        <property name="andMap" value="${r"$"}{andMap}"/>
      </include>
    </if>
  </delete>


  <!-- 统计数据数量（全部） -->
  <select id="countAll">
    SELECT COUNT(0) FROM ${table.nameSQL}
  </select>

  <!-- 根据条件统计数据数量（Where 拼接） -->
  <select id="countWhere">
    SELECT COUNT(0) FROM ${table.nameSQL} ${r"$"}{where}
  </select>

  <!-- 根据条件统计数据数量（灵活构建意图） -->
  <select id="countIntent">
    SELECT COUNT(0) FROM ${table.nameSQL}
    <include refid="whereIntent">
      <property name="orMap" value="${r"$"}{orMap}"/>
      <property name="andMap" value="${r"$"}{andMap}"/>
    </include>
  </select>

  <select id="findById">
    SELECT * FROM ${table.nameSQL} WHERE ${table.idColumn.name}=${r"#"}{id}
  </select>

  <select id="findOneWhere" resultMap="${table.className}">
    SELECT * FROM ${table.nameSQL} ${r"$"}{where} ${r"$"}{order}
  </select>

  <select id="findOneIntent" resultMap="${table.className}">
    SELECT * FROM ${table.nameSQL}
    <include refid="whereIntentOrder">
      <property name="orMap" value="${r"$"}{orMap}"/>
      <property name="andMap" value="${r"$"}{andMap}"/>
      <property name="orderMap" value="${r"$"}{orderMap}"/>
    </include>
  </select>

  <select id="findListWhere" resultMap="${table.className}">
    SELECT * FROM ${table.nameSQL} ${r"$"}{where} ${r"$"}{order}
  </select>

  <select id="findListIntent" resultMap="${table.className}">
    SELECT * FROM ${table.nameSQL}
    <include refid="whereIntentOrder">
      <property name="orMap" value="${r"$"}{orMap}"/>
      <property name="andMap" value="${r"$"}{andMap}"/>
      <property name="orderMap" value="${r"$"}{orderMap}"/>
    </include>
  </select>

</mapper>

