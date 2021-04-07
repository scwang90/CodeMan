<template>
    <el-card class="body" v-loading="loadingList">
        <template #header>
            <span class="title">${table.remarkName}管理</span>
            <el-input placeholder="输入关键字搜索" v-model="searchKey" class="input-search">
                <el-button slot="append" icon="el-icon-search" @click="onSearchClick"></el-button>
            </el-input>
            <el-button type="primary" icon="el-icon-circle-plus" @click="onAddClick">添加</el-button>
            <el-button type="danger" icon="el-icon-remove" @click="onRemoveClick">删除</el-button>
        </template>
        <el-table ref="table" class="table" height="100%" :data="items" @selection-change="onSelectionChange" stripe border highlight-current-row>
            <el-table-column fixed="left" type="selection" width="45"> </el-table-column>
            <el-table-column fixed="left" type="index" label="序号" width="50"> </el-table-column>
            <#list table.columns as column>
            <#if column != table.idColumn && column != table.passwordColumn && column != table.updateColumn && column != table.createColumn && !column.name?ends_with("_id")>
            <el-table-column prop="${column.fieldName}" label="${column.remark}" width="180"> </el-table-column>
            </#if>
            </#list>
            <el-table-column fixed="right" label="操作" width="150">
                <template #header>
                    <span>操作</span>
                    <!-- <el-input v-model="searchKey" size="mini" placeholder="输入关键字搜索" /> -->
                </template>
                <template #default="scope">
                <!-- <el-button @click="handleClick(scope.row)" type="text" size="small"
                    >查看</el-button
                > -->
                <!-- <el-button type="text" size="small">编辑</el-button> -->
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
        <el-dialog :title="`${r"$"}{model.id?'修改':'添加'}${table.remarkName}信息`" :visible.sync="showDialog" v-loading="loadingModel" :close-on-click-modal="false">
            <el-form :model="model" :rules="rules" ref="form" label-position="right" label-width="80px">
                <el-row>
            <#list table.columns as column>
                <#if column != table.idColumn && !column.hiddenForSubmit && !column.name?ends_with("_id") && column.name != "avatar">
                    <el-col :span="<#if (column.length > 32)>21<#else>10</#if>" :offset="1">
                        <el-form-item label="${column.remark}" prop="${column.fieldName}">
                            <#if column.dateType>
                            <el-date-picker type="date" placeholder="选择日期" v-model="model.${column.fieldName}" style="width: 100%;"></el-date-picker>
                            <#elseif (column.length > 64)>
                            <el-input v-model="model.${column.fieldName}" type="textarea" maxlength="${column.length}" show-word-limit></el-input>
                            <#else>
                            <el-input v-model="model.${column.fieldName}" <#if (column.length > 32)>maxlength="${column.length}" show-word-limit</#if>></el-input>
                            </#if>
                        </el-form-item>
                    </el-col>
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
</template>
<script>
import api from '@/api/${table.urlPathName}';

const rules = {
<#list table.columns as column>
    <#if column != table.idColumn && !column.hiddenForSubmit && (!column.nullable || column.stringType) && !column.name?ends_with("_id")>
    ${column.fieldName}: [
        <#if !column.nullable>
        { required: true, message: '请输入${column.remark}', trigger: 'blur' },
        </#if>
        <#if column.stringType>
        { min: 2, max: ${column.length}, message: '${column.remark}长度在 2 到 ${column.length} 个字符', trigger: 'blur' },
        </#if>
    ],
    </#if>
</#list>
};

export default {
    data() {
        return {
            page: 1,
            pageSize: 8,
            pageTotal: 0,

            searchKey: '',
            showDialog: false,
            loadingList: false,
            loadingModel: false,

            model: {},
            items: [],
            selections: [],
            rules: rules
        };
    },
    created() {
        this.init();
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
                this.$message.error(error);
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
                this.loadList(this.page);
            } catch (error) {
                this.$message.error(error)
            } finally {
                this.loadingModel = false;
            }
        },
        async requestRemove(item) {
            try {
                const ids = item.length ? item.map(i=>i.id).join(',') : item.id
                this.loadingList = true;
                await api.remove(ids);
                this.loadList(this.page);
            } catch (error) {
                this.$message.error(error);
            } finally {
                this.loadingList = false;
            }
        },
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
            this.model = item;
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
        },
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
    max-height: 100%;
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

</style>
