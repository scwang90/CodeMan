<template>
    <div class="body">
        <el-row class="row" :gutter="20">
            <el-col :span="3" v-for="(item,index) in buttons" :key="index">
                <el-button plain :type="item.type">
                    <div class="content">
                        <i class="icon" :class="`el-icon-${item.icon}`"></i>
                        <span>{{item.name}}</span>
                    </div>
                </el-button>
            </el-col>
        </el-row>
    </div>
</template>
<script>
export default {
    data() {
        return {
            buttons: [
                {name:'开单',icon:'document-add',type:null},
                {name:'上传',icon:'upload2',type:'primary'},
                {name:'初修',icon:'picture-outline-round',type:'success'},
                {name:'精修',icon:'picture-outline',type:'info'},
                {name:'调色',icon:'set-up',type:'warning'},
                {name:'质检',icon:'help',type:'danger'},
                {name:'设计',icon:'connection',type:'primary'},
                {name:'看板',icon:'view',type:null},
            ]
        }
    }
}
</script>
<style scoped>
.body {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
}
.row i{
    font-size: 50px;
}
.row > .el-col .content {
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 5px;
    /* background: #1bf5; */
}
.row > .el-col .content span {
    margin-top: 10px;
}
</style>