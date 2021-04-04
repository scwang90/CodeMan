import request from '@/plugins/request'

// @Summary ${table.remarkName}列表
// @Produce  application/json
// @Param query {size:"int",page:"int",skip:"int"}
// @Router '${table.urlPathName}/list' [get]
export const list = (data) => {
    return request.get('${table.urlPathName}/list', data)
}

// @Summary 添加${table.remarkName}
// @Produce  application/json
// @Param form {<#list table.columns as column><#if column != table.idColumn && column != table.updateColumn && column != table.createColumn>${column.fieldName}: "${column.fieldType}"<#if column_has_next>,</#if></#if></#list>}
// @Router '${table.urlPathName}/insert' [post]
export const insert = (data) => {
    return request.post('${table.urlPathName}/insert', data)
}


// @Summary 更新${table.remarkName}
// @Produce  application/json
// @Param form {<#list table.columns as column><#if column != table.idColumn && column != table.updateColumn && column != table.createColumn>${column.fieldName}: "${column.fieldType}"<#if column_has_next>,</#if></#if></#list>}
// @Router '${table.urlPathName}/update' [put]
export const update = (data) => {
    return request.put('${table.urlPathName}/update', data)
}

// @Summary 获取${table.remarkName}
// @Produce  application/json
// @Param path id
// @Router '${table.urlPathName}/{id}' [get]
export const get = (id) => {
    return request.get('${table.urlPathName}/' + id, {})
}

// @Summary 删除${table.remarkName}
// @Produce  application/json
// @Param path ids
// @Router '${table.urlPathName}/{ids}' [delete]
export const remove = (ids) => {
    return request.delete('${table.urlPathName}/' + ids, {})
}

export default {
    list, insert, update, get, remove
}
