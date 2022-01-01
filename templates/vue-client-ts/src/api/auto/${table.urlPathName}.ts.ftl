import request from '@/plugins/request'
import { ${className}<#if table.hasCascadeKey>, ${className}Bean</#if> } from '@/constant/models'
import * as Api from '@/constant/api'

<#assign beans = ['']/>
<#if table.hasCascadeKey>
    <#assign beans = ['', 'Bean']/>
</#if>
<#list beans as bean>
    <#assign value = '${table.remarkName}列表'/>
    <#if bean?length gt 0>
        <#assign value = value + '（包括外键）'/>
    </#if>
    <#assign notes = '分页参数支持两种形式，page 页数，skip 起始数据，两个传一个即可'/>
    <#if table.hasSearches>
        <#assign keys = '可以通过'/>
        <#list table.searchColumns as column>
            <#assign keys = keys + '[${column.remarkName}]'/>
            <#if column_has_next>
                <#assign keys = keys + '、'/>
            </#if>
        </#list>
        <#assign keys = keys + '等关键字搜索'/>
        <#assign notes = keys + '\\n' + notes/>
    </#if>

// @Summary ${value}
// @Summary ${notes}
// @Produce  application/json
// @Param query {size:"int",page:"int",skip:"int"<#if table.hasSearches>, key:"string"</#if>}
// @Router 'auto/${table.urlPathName}<#if bean?length gt 0>/${bean?lower_case}</#if>' [get]
export const list${bean} = (data: Api.Page<#if table.hasSearches> & Api.SearchKey</#if>): Promise<Api.Paged<${className}${bean}>> => {
    return request.get<Api.Paged<${className}${bean}>>('auto/${table.urlPathName}<#if bean?length gt 0>/${bean?lower_case}</#if>', data);
}
    <#list table.importCascadeKeys as key>

// @Summary 根据${key.pkTable.remarkName}获取${value}
// @Summary ${notes}
// @Produce  application/json
// @Param query {size:"int",page:"int",skip:"int"<#if table.hasSearches>, key:"string"</#if>}
// @Router 'auto/${table.urlPathName}<#if bean?length gt 0>/${bean?lower_case}</#if>/by/${key.fkColumn.fieldName}' [get]
export const list${bean}By${key.fkColumn.fieldNameUpper} = (data: Api.Page<#if table.hasSearches> & Api.SearchKey</#if> & { ${key.fkColumn.fieldName}: <#if key.fkColumn.longType && !key.fkColumn.forceUseLong>string<#else>${key.fkColumn.fieldType}</#if> }): Promise<Api.Paged<${className}${bean}>> => {
    return request.get<Api.Paged<${className}${bean}>>('auto/${table.urlPathName}<#if bean?length gt 0>/${bean?lower_case}</#if>/by/${key.fkColumn.fieldName}', data);
}
    </#list>
    <#list table.relateCascadeKeys as key>

// @Summary 根据${key.targetTable.remarkName}级联查询${value}
// @Summary ${notes}
// @Produce  application/json
// @Param query {size:"int",page:"int",skip:"int"<#if table.hasSearches>, key:"string"</#if>}
// @Router 'auto/${table.urlPathName}<#if bean?length gt 0>/${bean?lower_case}</#if>/relate/${key.relateTargetColumn.fieldName}' [get]
export const list${bean}ByRelate${key.relateTargetColumn.fieldNameUpper} = (data: Api.Page<#if table.hasSearches> & Api.SearchKey</#if> & { ${key.relateTargetColumn.fieldName}: <#if key.relateTargetColumn.longType && !key.relateTargetColumn.forceUseLong>string<#else>${key.relateTargetColumn.fieldType}</#if> }): Promise<Api.Paged<${className}${bean}>> => {
    return request.get<Api.Paged<${className}${bean}>>('auto/${table.urlPathName}<#if bean?length gt 0>/${bean?lower_case}</#if>/relate/${key.relateTargetColumn.fieldName}', data);
}
    </#list>
</#list>

<#assign isMore=false/>
// @Summary 添加${table.remarkName}
// @Produce  application/json
// @Param form {<#list table.columns as column><#if column != table.idColumn && column != table.updateColumn && column != table.createColumn><#if isMore>,</#if>${column.fieldName}: "${column.fieldTypeObject}"<#assign isMore=true/></#if></#list>}
// @Router '${table.urlPathName}' [post]
export const insert = (data: ${className}): Promise<number> => {
    return request.post<number>('auto/${table.urlPathName}', data);
}

<#assign isMore=false/>
// @Summary 更新${table.remarkName}
// @Produce  application/json
// @Param form {<#list table.columns as column><#if column != table.idColumn && column != table.updateColumn && column != table.createColumn><#if isMore>,</#if>${column.fieldName}: "${column.fieldTypeObject}"<#assign isMore=true/></#if></#list>}
// @Router '${table.urlPathName}' [put]
export const update = (data: ${className}): Promise<number> => {
    return request.put<number>('auto/${table.urlPathName}', data);
}

// @Summary 获取${table.remarkName}
// @Produce  application/json
// @Param path id
// @Router '${table.urlPathName}/{id}' [get]
export const get = (id: <#if table.idColumn.longType && !table.idColumn.forceUseLong>string<#else>${table.idColumn.fieldType}</#if>): Promise<${className}> => {
    return request.get<${className}>(`auto/${table.urlPathName}/${r"${id}"}`, {});
}

// @Summary 删除${table.remarkName}
// @Produce  application/json
// @Param path ids
// @Router '${table.urlPathName}/{ids}' [delete]
export const remove = (ids: string): Promise<number> => {
    return request.delete<number>(`auto/${table.urlPathName}/${r"${ids}"}`, {});
}

export default {
    <#list beans as bean>list${bean}, <#list table.importCascadeKeys as key>list${bean}By${key.fkColumn.fieldNameUpper}, </#list><#list table.relateCascadeKeys as key>list${bean}ByRelate${key.relateTargetColumn.fieldNameUpper}, </#list></#list>insert, update, get, remove
}
