module.exports = {
    // 基本路径
    publicPath: '/',
    // 输出文件目录
    outputDir: 'dist',
    // webpack-dev-server 相关配置
    devServer: {
        host: '0.0.0.0',
        port: 8000,
        https: false,
        proxy: 'http://localhost:8080', // 设置代理
    },
    // 第三方插件配置
    pluginOptions: {
        // ...
    }
}