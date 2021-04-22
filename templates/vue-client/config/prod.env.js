'use strict'

const config = require('../package.json');

module.exports = {
    NODE_ENV: '"production"',
    SETTING_API_BASE: '"/"',
    SETTING_WEB_NAME: `"${config.name}"`,
}
