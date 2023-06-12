<#function max(a, b)>
    <#return (a > b)?then(a, b)>
</#function>
<#function min(a, b)>
    <#return (a < b)?then(a, b)>
</#function>
<template>
<ViewFrame title="${table.remarkName}管理" v-loading="loadingList">
    <template #title>
        <el-input placeholder="输入关键字搜索" v-model="searchKey" class="input-search">
            <el-button slot="append" icon="el-icon-search" @click="onSearchClick"></el-button>
        </el-input>
        <el-button type="primary" icon="el-icon-circle-plus" @click="onAddClick">添加</el-button>
        <el-button type="danger" icon="el-icon-remove" @click="onRemoveClick">删除</el-button>
    </template>
    <el-card class="body">
        <el-table ref="table" class="table" height="100%" :data="items" @selection-change="onSelectionChange" stripe border highlight-current-row>
            <el-table-column fixed="left" type="selection" width="45"> </el-table-column>
            <el-table-column fixed="left" type="index" label="序号" width="50"> </el-table-column>
            <#list table.columns as column>
            <#if !column.hiddenForClient && !column.hiddenForTables && !column.name?lower_case?ends_with("id")>
            <el-table-column prop="${column.fieldName}" label="${column.remarkName}"<#if column==table.codeColumn> width="150"</#if>><#-- width="${min(max(column.clientLength*180/32, 80), 400)}" -->
                <#if column == table.genderColumn>
                <template #default="scope">
                    <span>{{scope.row.${column.fieldName}|gender}}</span>
                </template>
                <#elseif column.hasEnums>
                <template #default="scope">
                    <span>{{showEnum(scope.row.${column.fieldName}, enums.${column.fieldName})}}</span>
                </template>
                <#elseif column.hasEnumMap>
                <template #default="scope">
                    <span>{{showEnumMap(scope.row.${column.fieldName}, enumMap.${column.fieldName})}}</span>
                </template>
                <#elseif column.boolType>
                <template #default="scope">
                    <span v-text="scope.row.${column.fieldName} ? '是' : '否'"></span>
                </template>
                </#if>
            </el-table-column>
            </#if>
            </#list>
            <el-table-column fixed="right" label="操作" width="150">
                <template #default="scope">
                    <el-button size="mini" @click="onItemEditClick(scope.row)">编辑</el-button>
                    <el-button size="mini" type="danger" @click="onItemRemoveClick(scope.row)">删除</el-button >
                </template>
            </el-table-column>
        </el-table>
        <el-pagination class="page" background layout="prev, pager, next"
                :current-page="page"
                :page-size="pageSize"
                :total="pageTotal"
                :hide-on-single-page="true"
                @current-change="onPageIndex($event)">
        </el-pagination>
        <el-dialog :title="`${r"$"}{model.${table.idColumn.fieldName}?'修改':'添加'}${table.remarkName}信息`" :visible.sync="showDialog" v-loading="loadingModel" :close-on-click-modal="false">
            <el-form :model="model" :rules="rules" ref="form" label-position="right" label-width="100px">
                <el-row>
<#list table.importCascadeKeys as key>
                    <el-col :span="10" :offset="1">
                        <el-form-item label="${key.pkTable.remarkName}" prop="name">
                            <el-select v-model="model.${key.fkColumn.fieldName}" filterable placeholder="请选择">
                                <el-option
                                        v-for="item in modal${tools.toPlural(tools.toPlural(tools.idToModel(key.fkColumn.fieldName)))?cap_first}"
                                        :key="item.${key.pkTable.idColumn.fieldName}"
                                        :label="item.${key.pkTable.nameColumn.fieldName}"
                                        :value="item.${key.pkTable.idColumn.fieldName}">
                                </el-option>
                            </el-select>
                        </el-form-item>
                    </el-col>
</#list>
<#list table.columns as column>
    <#if !column.hiddenForClient && !column.name?lower_case?ends_with("id")>
        <#if column == table.passwordColumn>
                    <el-col :span="10" :offset="1" v-if="!model.${table.idColumn.fieldName}">
                        <el-form-item label="登录密码" prop="${column.fieldName}">
                            <el-input v-model="model.${column.fieldName}"></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="10" :offset="1" v-if="model.${table.idColumn.fieldName}">
                        <el-form-item label="账户密码" >
                            <el-input type="${column.fieldName}" value="**********" :disabled="true"></el-input>
                        </el-form-item>
                    </el-col>
        <#else>
                    <el-col :span="<#if (column.clientLength > 32)>21<#else>10</#if>" :offset="1"<#if column.hiddenForSubmit> v-if="model.${table.idColumn.fieldName}"</#if>>
                        <el-form-item label="${column.remarkName}" prop="${column.fieldName}">
            <#if column == table.genderColumn>
                            <el-radio-group v-model="model.${column.fieldName}"<#if column.hiddenForSubmit> :disabled="true"</#if>>
                                <el-radio :label="0">待定</el-radio>
                                <el-radio :label="1">男</el-radio>
                                <el-radio :label="2">女</el-radio>
                            </el-radio-group>
            <#elseif column.hasEnums>
                            <el-select v-model="model.${column.fieldName}"<#if column.hiddenForSubmit> :disabled="true"</#if> placeholder="请选择">
                                <template v-for="(item,index) in enums.${column.fieldName}">
                                <el-option v-if="!!item"
                                           :key="index"
                                           :label="item"
                                           :value="index">
                                </el-option>
                                </template>
                            </el-select>
            <#elseif column.hasEnumMap>
                            <el-select v-model="model.${column.fieldName}"<#if column.hiddenForSubmit> :disabled="true"</#if> placeholder="请选择">
                                <template v-for="(item,index) in enumMap.${column.fieldName}">
                                    <el-option v-if="!!item"
                                               :key="index"
                                               :label="enumMap.${column.fieldName}[item]"
                                               :value="item">
                                    </el-option>
                                </template>
                            </el-select>
            <#elseif column.boolType>
                            <el-switch v-model="model.${column.fieldName}" active-text="已${column.remarkName}" inactive-text="未${column.remarkName}"<#if column.hiddenForSubmit> :disabled="true"<#else> </#if>/>
            <#elseif column.dateType>
                            <el-date-picker type="${(column.dateTimeType==true)?string('datetime','date')}" v-model="model.${column.fieldName}"<#if column.hiddenForSubmit> :disabled="true"<#else> placeholder="选择日期" value-format="yyyy-MM-dd"</#if>></el-date-picker>
            <#elseif (column.clientLength > 64)>
                            <el-input v-model="model.${column.fieldName}" type="textarea" :autosize="{minRows:${column.clientLength?c}/64, maxRows:6}"<#if column.hiddenForSubmit> :disabled="true"<#else> maxlength="${column.length}" show-word-limit @keyup.ctrl.enter.native="onSubmitClick"</#if>></el-input>
            <#else>
                            <el-input v-model="model.${column.fieldName}"<#if column.hiddenForSubmit> :disabled="true"<#else> <#if (column.length > 32)>maxlength="${column.length}" show-word-limit</#if> @keyup.ctrl.enter.native="onSubmitClick"</#if>></el-input>
            </#if>
                        </el-form-item>
                    </el-col>
        </#if>
    </#if>
</#list>
                </el-row>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="showDialog = false">取 消</el-button>
                <el-button type="primary" @click="onSubmitClick">{{model.id?'修 改':'添 加'}}</el-button>
            </div>
        </el-dialog>
    </el-card>
</ViewFrame>
</template>
<script>
import api from '@/api/auto/${table.urlPathName}'
<#list table.importCascadeKeys as key>
import api${tools.toPlural(tools.idToModel(key.fkColumn.fieldName))?cap_first} from '@/api/auto/${key.pkTable.urlPathName}'
</#list>
import ViewFrame from '@/components/ViewFrame'

const rules = {
<#list table.columns as column>
    <#if column != table.idColumn && !column.hiddenForSubmit && (!column.nullable || column.stringType) && !column.name?lower_case?ends_with("id")>
    ${column.fieldName}: [
        <#if !column.nullable>
        { required: true, message: '请输入${column.remark}', trigger: 'blur' },
        </#if>
        <#if column.stringType>
            <#assign minLength=1/>
            <#if column == table.usernameColumn>
                <#assign minLength=5/>
            </#if>
            <#if column == table.passwordColumn>
                <#assign minLength=6/>
            </#if>
        { min: ${minLength}, max: ${column.length?c}, message: '${column.remark}长度在 ${minLength} 到 ${column.length} 个字符', trigger: 'blur' },
        </#if>
    ],
    </#if>
</#list>
};
<#if table.hasColumnEnums>

const enums = {
    <#list table.columns as column>
        <#if column.hasEnums>
    /**
     * ${column.remark}
     <#list column.descriptions as description>
     * ${description}
     </#list>
     */
    ${column.fieldName}: [
            <#assign index = 0/>
            <#list column.enums as enum>
                <#if index < enum.value>
                    <#list index..(enum.value-1) as i>
        '',
                    </#list>
        '${enum.name}',
                    <#assign index = enum.value + 1/>
                <#else>
        '${enum.name}',
                    <#assign index = index + 1/>
                </#if>
            </#list>
    ],
        </#if>
    </#list>
}
</#if>
<#if table.hasColumnEnumMap>

const enumMap = {
    <#list table.columns as column>
        <#if column.hasEnumMap>
    /**
     * ${column.remark}
     <#list column.descriptions as description>
     * ${description}
     </#list>
     */
    ${column.fieldName}: {
        <#assign index = 0/>
        <#list column.enumMap?keys as key>
        '${key}': '${column.enumMap[key]}',
        </#list>
    },
    </#if>
    </#list>
}
</#if>

export default {
    components: { ViewFrame },
    data() {
        return {
            page: 1,
            pageSize: 8,
            pageTotal: 0,

            searchKey: '',
            showDialog: false,
            loadingList: false,
            loadingModel: false,
<#list table.importCascadeKeys as key>

            modal${tools.toPlural(tools.idToModel(key.fkColumn.fieldName))?cap_first}: [],
            loading${tools.toPlural(tools.idToModel(key.fkColumn.fieldName))?cap_first}: false,
</#list>

            model: {},
            items: [],
            selections: [],
<#if table.hasColumnEnums>
            enums: enums,
</#if>
<#if table.hasColumnEnumMap>
            enumMap: enumMap,
</#if>
            rules: rules
        };
    },
    created() {
        this.init();
<#list table.importCascadeKeys as key>
        this.load${tools.toPlural(tools.idToModel(key.fkColumn.fieldName))?cap_first}();
</#list>
    },
    watch: {
        $route(to, from) {
            if (to.params.page) {
                this.page = Number(to.params.page);
            }
            this.init();
        },
    },
    methods: {
        init() {
            this.items = [];
            this.loadList(this.page = this.$route.params.page ? Number(this.$route.params.page) : 1);//默认加载第一页
        },
        ...Object.assign({
<#list table.importCascadeKeys as key>
            async load${tools.toPlural(tools.idToModel(key.fkColumn.fieldName))?cap_first}() {
                const params = { page: 0, size: 100, key: '' };
                try {
                    this.loading${tools.toPlural(tools.idToModel(key.fkColumn.fieldName))?cap_first} = true;
                    const result = await api${tools.toPlural(tools.idToModel(key.fkColumn.fieldName))?cap_first}.list(params);
                    this.modal${tools.toPlural(tools.idToModel(key.fkColumn.fieldName))?cap_first} = result.list;
                } catch (error) {
                    this.$message.error(`${r"${error}"}`);
                } finally {
                    this.loading${tools.toPlural(tools.idToModel(key.fkColumn.fieldName))?cap_first} = false;
                }
            },
</#list>
            async loadList(index) {
                const params = {
                    page: index - 1,
                    size: this.pageSize,
                    key: this.searchKey,
                };
                try {
                    this.loadingList = true;
                    const result = await api.list(params);
                    this.items = result.list;
                    this.pageTotal = result.totalRecord;
                } catch (error) {
                    this.$message.error(`${r"${error}"}`);
                } finally {
                    this.loadingList = false;
                }
            },
            async postSubmit() {
                try {
                    this.loadingModel = true;
                    if (this.model.id) {
                        await api.update(this.model);
                    } else {
                        await api.insert(this.model);
                    }
                    this.showDialog = false;
                    this.$message.success('保存成功');
                    this.loadList(this.page);
                } catch (error) {
                    this.$message.error(`${r"${error}"}`);
                } finally {
                    this.loadingModel = false;
                }
            },
            async requestRemove(item) {
                try {
                    const ids = item.length ? item.map(i=>i.id).join(',') : item.id
                    this.loadingList = true;
                    await api.remove(ids);
                    this.$message.success('删除成功');
                    this.loadList(this.page);
                } catch (error) {
                    this.$message.error(`${r"${error}"}`);
                } finally {
                    this.loadingList = false;
                }
            }
        }),
        ...Object.assign({
            onPageIndex(page) {
                this.$router.push({
                    params: {inner: true, page},
                    query: this.$route.query,
                    name: this.$route.name.replace(/(-page)?$/,'-page'),
                });
            },
            onSelectionChange(selections) {
                this.selections = selections;
            },
            onSearchClick() {
                this.loadList(this.page);
            },
            onAddClick() {
                this.model = {};
                this.showDialog = true;
            },
            onRemoveClick() {
                if (!this.selections || !this.selections.length) {
                    this.$message.info('请先在列表左边勾选需要删除到行!');
                } else {
                    this.$confirm('此操作将永久删除多条数据, 是否继续?', '提示', {
                        confirmButtonText: '确定',
                        cancelButtonText: '取消',
                        type: 'warning'
                    }).then(() => {
                        this.requestRemove(this.selections);
                    }).catch(() => {
                        this.$message({ type: 'info', message: '已取消删除'});
                    });
                }
            },
            onItemEditClick(item) {
                this.model = {...item};
                this.showDialog = true;
            },
            onItemRemoveClick(item) {
                this.$confirm('此操作将永久删除该, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.requestRemove(item);
                }).catch(() => {
                    this.$message({ type: 'info', message: '已取消删除'});
                });
            },
            onSubmitClick() {
                this.$refs.form.validate((valid) => {
                    if (valid) {
                        this.postSubmit();
                    }
                    return valid;
                });
<#if table.hasColumnEnums>
            },
            showEnum(value, enums) {
                if (value >= enums.length) {
                    return `${r"${value}"}`;
                }
                if (enums[value]) {
                    return enums[value];
                }
                return `${r"${value}"}`;
</#if>
<#if table.hasColumnEnumMap>
            },
            showEnumMap(value, enums) {
                if (enums[value]) {
                    return enums[value];
                }
                return `${r"${value}"}`;
</#if>
            }
        }),
    }
};
</script>
<style>
.body .el-card__body {
    flex: 1;
    overflow: hidden;
    display: flex;
    flex-direction: column;
}
.body .el-card__header {
    display: flex;
    align-items: center;
}
</style>
<style scoped>
.body {
    overflow: hidden;
    display: flex;
    flex-direction: column;
    height: 100%;
    box-sizing: border-box;
}
.body .title {
    flex: 1;
}
.body .table {
    flex: 1;
}
.page {
    margin-top: 10px;
    align-self: flex-end;
}
.el-input.input-search {
    width: 250px;
    margin: 0 10px;
}
.el-select {
    width: 100%;
}
</style>
