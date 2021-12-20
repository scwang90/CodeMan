import request from '@/plugins/request'

// @Summary ${table.remarkName}列表
// @Produce  application/json
// @Param query {size:"int",page:"int",skip:"int"}
// @Router '${table.urlPathName}' [get]
export const list = (data) => {
    return request.get('auto/${table.urlPathName}', data)
}

<#assign isMore=false/>
// @Summary 添加${table.remarkName}
// @Produce  application/json
// @Param form {<#list table.columns as column><#if column != table.idColumn && column != table.updateColumn && column != table.createColumn><#if isMore>,</#if>${column.fieldName}: "${column.fieldTypeObject}"<#assign isMore=true/></#if></#list>}
// @Router '${table.urlPathName}' [post]
export const insert = (data) => {
    return request.post('auto/${table.urlPathName}', data)
}

<#assign isMore=false/>
// @Summary 更新${table.remarkName}
// @Produce  application/json
// @Param form {<#list table.columns as column><#if column != table.idColumn && column != table.updateColumn && column != table.createColumn><#if isMore>,</#if>${column.fieldName}: "${column.fieldTypeObject}"<#assign isMore=true/></#if></#list>}
// @Router '${table.urlPathName}' [put]
export const update = (data) => {
    return request.put('auto/${table.urlPathName}', data)
}

// @Summary 获取${table.remarkName}
// @Produce  application/json
// @Param path id
// @Router '${table.urlPathName}/{id}' [get]
export const get = (id) => {
    return request.get('auto/${table.urlPathName}/' + id, {})
}

// @Summary 删除${table.remarkName}
// @Produce  application/json
// @Param path ids
// @Router '${table.urlPathName}/{ids}' [delete]
export const remove = (ids) => {
    return request.delete('auto/${table.urlPathName}/' + ids, {})
}

export default {
    list, insert, update, get, remove
}
