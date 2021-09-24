import Vue from 'vue'
export type VueType = typeof Vue;

const isDebug = process.env.NODE_ENV == 'development';

const $log:(...data: any[])=>void = console.log.bind(console);
const $warn:(...data: any[])=>void = console.warn.bind(console);
const $error:(...data: any[])=>void = console.error.bind(console);
const $info:(...data: any[])=>void = console.info.bind(console);

const $logger = {
    prefix: '',//'logger',
    install(Vue: VueType) {
        Vue.prototype.$logger = $logger;

        console.log = this.log.bind(this);
        console.warn = this.warn.bind(this);
        console.error = this.error.bind(this);
        console.info = this.info.bind(this);
        console.debug = console.log;
    },
    logger(logger: null | ((...data: any[])=>void), name: string, _arguments: IArguments, color: string, margin?: string) {
        if (logger) {
            margin = margin || '';
            const args: string[] = [].slice.apply(_arguments);
            if (this.prefix) {
                name = this.prefix + name;
            }
            if (args.length == 0) {
                args.push('%c' + name+ '%c');
                args.push('background:' + color + ';font-size:13px;padding: 3px 6px;border-radius: 3px;color: #fff;' + margin);
                args.push('background:transparent');
            } else if (args.length > 0) {
                if (Object.prototype.toString.call(args[0]) === '[object String]') {
                    if (args[0].indexOf('%c') >= 0) {
                        args.unshift('background:transparent');
                        args.unshift('background:' + color + ';font-size:13px;padding: 3px 6px;border-radius: 3px;color: #fff;' + margin);
                        args.unshift('%c' + name+ '%c ' + args[2]);
                        args.splice(3, 1);
                    } else {
                        args.unshift('background:#35495e;font-size:13px;padding: 3px 6px;border-radius: 0 3px 3px 0;color: #fff;');
                        args.unshift('background:' + color + ';font-size:13px;padding: 3px 6px;border-radius: 3px 0 0 3px;color: #fff;' + margin);
                        args.unshift('%c' + name+ '%c' + args[2]);
                        args.splice(3, 1);
                    }
                } else {
                    args.unshift('background:transparent');
                    args.unshift('background:' + color + ';font-size:13px;padding: 3px 6px;border-radius: 3px;color: #fff;' + margin);
                    args.unshift('%c' + name+ '%c');
                }
            } else {
                args.unshift(this.prefix);
            }
            logger(...args);
        }
    },
    log() {
        this.logger(isDebug?$log:null, '调试', arguments, '#1F6FB5', 'margin-left:10px;');
    },
    info() {
        this.logger(isDebug?$info:null, '信息', arguments, '#41b883', 'margin-left:10px;');
    },
    warn() {
        this.logger($warn, '警告', arguments, '#F29F3F');
    },
    error() {
        this.logger($error, '错误', arguments, '#F01B2D');
    }
};

export default $logger;
