# 数据字典 ${projectName}

## 表目录
| 表名 | 说明 |
|:---:|:---:|
<#list tables as table>
|[${table.name}](#${table.name})|${table.comment}|
</#list>

<#list tables as table>

## 表 ${table.name} ${table.comment}

|  序号  | 名称 | 数据类型 | 长度 | 默认值 | 非空 | 主键 | 自动递增 | 备注 |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:----:|:---:|
<#list table.columns as column>
|${column_index+1}|${column.name}|${column.type}|${column.length}|${column.defValue}|${column.nullable?string('空','')}|${column.primaryKey?string('是','')}|${column.autoIncrement?string('自增','')}|${column.remark}|
</#list>
</#list>
