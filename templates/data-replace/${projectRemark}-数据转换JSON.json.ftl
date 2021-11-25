{
  "tables":[
<#list tables as table>
    {
      "name": "${table.name}",
      "newName": "${table.replaceName}",
      "comment": "${table.comment}",
      "newComment": "${table.replaceRemark}",
      "columns": [
      <#list table.columns as column>
        {
          "name": "${column.name}",
          "newName": "${column.replaceName}",
          "comment": "${column.comment}",
          "newComment": "${column.replaceRemark}",
          "type": "${column.typeJdbc}",
          "length": ${column.length?c},
          "nullable": ${column.nullable?c}
        }<#if column_has_next>,</#if>
      </#list>
      ]
    }<#if table_has_next>,</#if>
</#list>
  ]
}