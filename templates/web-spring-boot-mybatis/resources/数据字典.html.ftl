<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>数据字典 ${projectName}</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container"><h1 style="text-align:center;">数据字典 ${projectName}</h1>

    <#list tables as table>
    <h3><b>表</b> : <span>${table.name}</span> = ${table.remark}</h3>
    <table class="table table-hover table-bordered table-condensed table-striped">
        <thead>
        <tr>
            <th>字段名</th>
            <th>数据类型</th>
            <th>列长</th>
            <th>默认值</th>
            <th>非空</th>
            <th>自动递增</th>
            <th>备注</th>
        </tr>
        </thead>
        <tbody>

        <#list table.columns as column>
        <tr>
            <td>${column.name}</td>
            <td>${column.type}</td>
            <td>${column.length}</td>
            <td>${column.defValue}</td>
            <td><#if column.nullable></#if><#if !column.nullable>是</#if></td>
        <td><#if column.autoIncrement>自增</#if></td>
        <td>${column.remark}</td>
        </tr>
        </#list>
        </tbody>
    </table>
</#list>

</div>
</body>
</html>