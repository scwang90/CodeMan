module.exports = {
    // 基本路径
    baseUrl: '/',
    // 输出文件目录
    outputDir: 'dist',
    // webpack-dev-server 相关配置
    devServer: {
        host: '0.0.0.0',
        port: 8000,
        https: false,
        proxy: null, // 设置代理
        before: app => {}
    },
    // 第三方插件配置
    pluginOptions: {
        // ...
    }
}