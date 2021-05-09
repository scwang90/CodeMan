'use strict'

const config = require('../package.json');

let apiBase = '"/"';
let apiBaseArg = process.argv.find(arg=>arg.startsWith('--apiBase='));
if (apiBaseArg) {
    apiBase = `"/${apiBaseArg.substring(10)}/"`;
}

let routerBase = '"/"';
let routerMode = '"hash"';
if (process.argv.find(arg=>arg=='--history')) {
    routerMode = '"history"';
    let publicPathArg = process.argv.find(arg=>arg.startsWith('--publicPath'));
    if (publicPathArg) {
        if (publicPathArg.startsWith('--publicPath=')) {
            routerBase = `"${publicPathArg.substring(13)}"`;
        } else {
            throw Error("history 模式必须具体指定 publicPath 的值");
        }
    }
}

module.exports = {
    NODE_ENV: '"production"',
    ROUTER_MODE: routerMode,
    ROUTER_BASE: routerBase,
    SETTING_API_BASE: apiBase,
    SETTING_WEB_NAME: `"${config.name}"`,
}
