<template>
  <!-- <div id="app">
    <img src="./assets/logo.png">
    <router-view/>
  </div> -->
  <router-view id="app"/>
</template>

<script>
export default {
  name: 'App'
}
</script>

<style>
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
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  /* text-align: center; */
  color: #2c3e50;
  /* margin-top: 60px; */
}
</style>
