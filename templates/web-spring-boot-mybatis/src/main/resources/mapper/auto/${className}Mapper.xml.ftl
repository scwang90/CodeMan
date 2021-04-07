<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${packageName}.mapper.auto.${className}Mapper">
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

  <sql id="sql_where_item_II">
    <choose>
      <when test="whereII.value != null">
        <choose>
          <when test="whereI.op == 'IN'">
            ${r"$"}{whereII.column} IN
            <foreach collection="value" item="item" open="(" close=")" separator=",">
              ${r"#"}{item}
            </foreach>
          </when>
          <otherwise>
            ${r"$"}{whereII.column} ${r"$"}{whereII.op} ${r"#"}{whereII.value}
          </otherwise>
        </choose>
      </when>
      <otherwise>
        ${r"$"}{whereII.column} ${r"$"}{whereII.op}
      </otherwise>
    </choose>
  </sql>

  <sql id="sql_where_II">
    <choose>
      <when test="whereI.op == 'OR'">
        <foreach collection="whereI.wheres" item="whereII" open="(" close=")" separator="OR">
          <include refid="sql_where_item_II" />
        </foreach>
      </when>
      <otherwise>
        <foreach collection="whereI.wheres" item="whereII" open="(" close=")" separator="AND">
          <include refid="sql_where_item_II" />
        </foreach>
      </otherwise>
    </choose>
  </sql>

  <sql id="sql_where_item_I">
    <choose>
      <when test="whereI.wheres != null">
        <include refid="sql_where_II"/>
      </when>
      <otherwise>
        <choose>
          <when test="whereI.value != null">
            <choose>
              <when test="whereI.op == 'IN'">
                ${r"$"}{whereI.column} IN
                <foreach collection="value" item="item" open="(" close=")" separator=",">
                  ${r"#"}{item}
                </foreach>
              </when>
              <otherwise>
                ${r"$"}{whereI.column} ${r"$"}{whereI.op} ${r"#"}{whereI.value}
              </otherwise>
            </choose>
          </when>
          <otherwise>
            ${r"$"}{whereI.column} ${r"$"}{whereI.op}
          </otherwise>
        </choose>
      </otherwise>
    </choose>
  </sql>

  <sql id="sql_where_I">
    <choose>
      <when test="where.op == 'OR'">
        <foreach collection="where.wheres" item="whereI" open="(" close=")" separator="OR">
          <include refid="sql_where_item_I" />
        </foreach>
      </when>
      <otherwise>
        <foreach collection="where.wheres" item="whereI" open="(" close=")" separator="AND">
          <include refid="sql_where_item_I" />
        </foreach>
      </otherwise>
    </choose>
  </sql>

  <sql id="sql_where_item">
    <choose>
      <when test="where.wheres != null">
        <include refid="sql_where_I"/>
      </when>
      <otherwise>
        <choose>
          <when test="where.value != null">
            <choose>
              <when test="where.op == 'IN'">
                ${r"$"}{where.column} IN
                <foreach collection="value" item="item" open="(" close=")" separator=",">
                  ${r"#"}{item}
                </foreach>
              </when>
              <otherwise>
                ${r"$"}{where.column} ${r"$"}{where.op} ${r"#"}{where.value}
              </otherwise>
            </choose>
          </when>
          <otherwise>
            ${r"$"}{where.column} ${r"$"}{where.op}
          </otherwise>
        </choose>
      </otherwise>
    </choose>
  </sql>

  <sql id="sql_where_internal">
    <choose>
      <when test="column != null">
        <choose>
          <when test="value != null">
            <choose>
              <when test="op == 'IN'">
                ${r"$"}{column} IN
                <foreach collection="value" item="item" open="(" close=")" separator=",">
                  ${r"#"}{item}
                </foreach>
              </when>
              <otherwise>
            ${r"$"}{column} ${r"$"}{op} ${r"#"}{value}
              </otherwise>
            </choose>
          </when>
          <otherwise>
            ${r"$"}{column} ${r"$"}{op}
          </otherwise>
        </choose>
      </when>
      <when test="wheres != null">
        <choose>
          <when test="op == 'OR'">
            <foreach collection="wheres" item="where" separator=" OR ">
              <include refid="sql_where_item" />
            </foreach>
          </when>
          <otherwise>
            <foreach collection="wheres" item="where" separator=" AND ">
              <include refid="sql_where_item" />
            </foreach>
          </otherwise>
        </choose>
      </when>
    </choose>
  </sql>

  <sql id="sql_where">
    <where>
      <include refid="sql_where_internal"/>
    </where>
  </sql>

  <sql id="sql_order">
    <choose>
      <when test="orders != null and orders.size > 0">
        ORDER BY
        <foreach collection="orders" item="order" separator=" , ">
          ${r"$"}{order.column}
          <if test="order.desc">
            DESC
          </if>
        </foreach>
      </when>
      <otherwise>
        <#if table.hasCode>
        ORDER BY ${table.codeColumn.nameSql}
        </#if>
      </otherwise>
    </choose>
  </sql>

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
      <include refid="sql_where_internal"/>
    </if>
  </update>

  <!-- 根据ID删除（支持批量删除）-->
  <delete id="deleteById">
    DELETE FROM ${table.nameSql} WHERE ${table.idColumn.nameSql} IN
    <foreach collection="ids" item="id" open="(" close=")" separator=",">
      ${r"#"}{id}
    </foreach>
  </delete>

  <!-- 根据条件删除（灵活构建查询条件） -->
  <delete id="deleteWhere">
      DELETE FROM ${table.nameSql} WHERE
      <include refid="sql_where_internal"/>
  </delete>

  <!-- 统计数据数量（全部） -->
  <select id="countAll" resultType="java.lang.Integer">
    SELECT COUNT(0) FROM ${table.nameSql}
  </select>

  <!-- 根据条件统计数据数量（灵活构建查询条件） -->
  <select id="countWhere" resultType="java.lang.Integer">
    SELECT COUNT(0) FROM ${table.nameSql}
    <include refid="sql_where"/>
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
    <include refid="sql_where"/>
    <include refid="sql_order"/>
  </select>

  <!-- 批量查询（灵活构建查询条件） -->
  <select id="selectWhere" resultMap="MAP">
    SELECT * FROM ${table.nameSql}
    <include refid="sql_where"/>
    <include refid="sql_order"/>
  </select>

</mapper>

