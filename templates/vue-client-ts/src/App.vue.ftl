<template>
  <router-view id="app"/>
</template>

<style lang="scss">
  html,body {
    height: 100%;
    margin: 0;
    /* background-image: url('/static/ui/ui-login.png'); */
    /* background-image: url('/static/ui/ui-index.png'); */
    background-size: 100% auto;
    font-size: 16px;
  }
  body > div {
    /* opacity: 0.5; */
  }
  #app {
    /*font-family: 'Avenir', Helvetica, Arial, sans-serif; */
    /*-webkit-font-smoothing: antialiased; */
    /*-moz-osx-font-smoothing: grayscale; */
    /*color: #2c3e50; */
  }
  .el-form-item .el-select,
  .el-form-item .el-date-editor,
  .el-form-item .el-cascader {
    width: 100%;
  }
</style>
