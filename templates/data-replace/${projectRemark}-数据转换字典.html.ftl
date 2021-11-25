<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>数据字典 ${projectName}</title>
    <link href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/5.0.0-beta2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .green {
            color: green;
        }
    </style>
</head>
<body>
<div class="container">
    <h1 style="text-align:center;">表名替换 ${projectName}</h1>
    <table class="table table-hover table-bordered table-condensed table-striped">
        <thead>
        <tr>
            <th>序号</th>
            <th>新表名(绿色：替换)</th>
            <th>原表名</th>
            <th>备注（绿色：替换）</th>
        </tr>
        </thead>
        <#list tables as table>
        <tr>
            <td>${table_index}</td>
            <td class="<#if table.name != table.replaceName>green</#if>">${table.replaceName}</td>
            <td>${table.name}</td>
            <#-- <td class="green">${table.replaceRemark?length > 0}</td>-->
            <#if (table.replaceRemark?length > 0) >
                <td class="green">${table.replaceRemark}</td>
            <#else>
                <td>${table.comment}</td>
            </#if>
        </tr>
        </#list>
    </table>
    <h1 style="text-align:center;">详细替换 ${projectName}</h1>
    <#list tables as table>
        <h3><b>表</b> : <span>${table.name}</span> -> <span class="<#if table.name != table.replaceName>green</#if>">${table.replaceName}</span> [${table.comment}]</h3>
        <table class="table table-hover table-bordered table-condensed table-striped" name="${table.name}" remark="${table.remark}">
            <thead>
            <tr>
                <th>序号</th>
                <th>原字段</th>
                <th>新字段</th>
                <th>数据类型</th>
<#--                <th>列长</th>-->
<#--                <th>默认值</th>-->
<#--                <th>非空</th>-->
<#--                <th>主键</th>-->
<#--                <th>自动递增</th>-->
                <th>备注（绿色：需要替换）</th>
            </tr>
            </thead>
            <tbody>

            <#list table.columns as column>
                <tr>
                    <td>${column_index}</td>
                    <td>${column.name}</td>
                    <td class="<#if column.name != column.replaceName>green</#if>">${column.replaceName}</td>
                    <td>${column.type}</td>
<#--                    <td>${column.length}</td>-->
<#--                    <td>${column.defValue}</td>-->
<#--                    <td><#if column.nullable></#if><#if !column.nullable>是</#if></td>-->
<#--                    <td><#if column.primaryKey>是</#if><#if !column.primaryKey></#if></td>-->
<#--                    <td><#if column.autoIncrement>自增</#if></td>-->
                    <#if (column.replaceRemark?length > 0) >
                        <td class="green">${column.replaceRemark}</td>
                    <#else>
                        <td>${column.comment}</td>
                    </#if>
                </tr>
            </#list>
            </tbody>
        </table>
    </#list>

</div>
</body>
</html>