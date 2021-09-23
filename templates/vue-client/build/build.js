'use strict'
require('./check-versions')()

process.env.NODE_ENV = 'production'

const ora = require('ora')
const rm = require('rimraf')
const path = require('path')
const chalk = require('chalk')
const webpack = require('webpack')
const config = require('../config')
const webpackConfig = require('./webpack.prod.conf')

const KEY_SCP = '--scp';

let scpConf = null;
let scp = process.argv.find(arg=>arg.startsWith(KEY_SCP));
if (scp) {
    scp = scp.substring(KEY_SCP.length);
    if (scp.startsWith('=')) {
        scp = scp.substring(1);
        let matches = /^(\S+)\/(\S+)@(\S+):(\S+)$/.exec(scp);
        if (!matches) {
            throw new Error(`SCP格式无效:${scp}`);
        } else {
            scpConf = {
                host: matches[3],
                path: matches[4],
                username: matches[1],
                password: matches[2],
            }
        }
    } else {
        scpConf = require('../config/scp');
    }
}

const spinner = ora('building for production...')
spinner.start()

rm(path.join(config.build.assetsRoot, config.build.assetsSubDirectory), err => {
  if (err) throw err
  webpack(webpackConfig, (err, stats) => {
    spinner.stop()
    if (err) throw err
    process.stdout.write(stats.toString({
      colors: true,
      modules: false,
      children: false, // If you are using ts-loader, setting this to true will make TypeScript errors show up during build.
      chunks: false,
      chunkModules: false
    }) + '\n\n')

    if (stats.hasErrors()) {
      console.log(chalk.red('  Build failed with errors.\n'))
      process.exit(1)
    }

    console.log(chalk.cyan('  Build complete.\n'))
    console.log(chalk.yellow(
      '  Tip: built files are meant to be served over an HTTP server.\n' +
      '  Opening index.html over file:// won\'t work.\n'
    ))
    if (scpConf) {
      const spinner = ora(`正在上传到服务器:${scpConf.username}@${scpConf.host}:${scpConf.path}`);
      spinner.start();

      require('scp2').scp(config.build.assetsRoot, scpConf,
          function (err) {
              spinner.stop();
              if (err) {
                  console.log(chalk.red('发布失败.\n' + err));
                  process.exit(1);
              } else {
                  console.log(chalk.green(`成功发布到服务器:${scpConf.username}@${scpConf.host}:${scpConf.path}`));
              }
          }
      );
    }
  })
})
