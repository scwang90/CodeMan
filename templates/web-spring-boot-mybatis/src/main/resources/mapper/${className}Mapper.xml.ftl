<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${packageName}.mapper.common.${className}Mapper">
  <resultMap id="ResultMap" type="${packageName}.model.db.${className}">
    <#list table.columns as column>
    <#if table.idColumn.nameSQL == column.nameSQL>
      <id column="${column.nameSQL}" jdbcType="${column.typeMyBatis}" property="${column.fieldType}" />
    <#else >
      <result column="${column.nameSQL}" jdbcType="${column.typeMyBatis}" property="${column.fieldType}" />
    </#if>
    </#list>
  </resultMap>
</mapper>

