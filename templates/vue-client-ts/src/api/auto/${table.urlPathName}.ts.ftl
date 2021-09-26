import request from '@/plugins/request'
import ${className} from '@/model/auto/${table.urlPathName}'
import * as Api from '@/constant/api'

// @Summary ${table.remarkName}列表
// @Produce  application/json
// @Param query {size:"int",page:"int",skip:"int"}
// @Router '${table.urlPathName}' [get]
export const list = (data: Api.Page): Promise<Api.Paged<${className}>> => {
    return request.get<Api.Paged<${className}>>('/api/v1/${table.urlPathName}', data)
}

// @Summary 添加${table.remarkName}
// @Produce  application/json
// @Param form {<#list table.columns as column><#if column != table.idColumn && column != table.updateColumn && column != table.createColumn>${column.fieldName}: "${column.fieldType}"<#if column_has_next>,</#if></#if></#list>}
// @Router '${table.urlPathName}' [post]
export const insert = (data: ${className}): Promise<number> => {
    return request.post<number>('/api/v1/${table.urlPathName}', data)
}

// @Summary 更新${table.remarkName}
// @Produce  application/json
// @Param form {<#list table.columns as column><#if column != table.idColumn && column != table.updateColumn && column != table.createColumn>${column.fieldName}: "${column.fieldType}"<#if column_has_next>,</#if></#if></#list>}
// @Router '${table.urlPathName}' [put]
export const update = (data: ${className}): Promise<number> => {
    return request.put<number>('/api/v1/${table.urlPathName}', data)
}

// @Summary 获取${table.remarkName}
// @Produce  application/json
// @Param path id
// @Router '${table.urlPathName}/{id}' [get]
export const get = (id: <#if table.idColumn.stringType>string<#else>number</#if>): Promise<${className}> => {
    return request.get<${className}>('/api/v1/${table.urlPathName}/' + id, {})
}

// @Summary 删除${table.remarkName}
// @Produce  application/json
// @Param path ids
// @Router '${table.urlPathName}/{ids}' [delete]
export const remove = (ids: string): Promise<number> => {
    return request.delete<number>('/api/v1/${table.urlPathName}/' + ids, {})
}

export default {
    list, insert, update, get, remove
}
