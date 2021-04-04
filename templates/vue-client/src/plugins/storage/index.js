import {Base64} from 'js-base64'

class DefaultSrorage {
    constructor(name) {
        this.name = name;
    }
    setItem() {
        console.warn('storage.getItem window.%s 不支持', this.name);
    }
    removeItem() {
        console.warn('storage.getItem window.%s 不支持', this.name);
    }
    getItem() {
        console.warn('storage.getItem window.%s 不支持', this.name);
        return null;
    }
}

class StorageImpl {
    constructor(name, local, base64, prefix) {
        this.name = name;
        this.local = local;
        this.base64 = base64;
        this.prefix = prefix;
    }
    get(key) {
        if (this.prefix) {
            key = this.prefix + '-' + key;
        }
        if (this.base64) {
            key = Base64.encode(key);
        }
        let value = this.local.getItem(key);
        if (value) {
            if (this.base64) {
                value = Base64.decode(value);
            }
            value = JSON.parse(value)
        }
        return value;
    }
    set(key, value) {
        if (this.prefix) {
            key = this.prefix + '-' + key;
        }
        if (this.base64) {
            key = Base64.encode(key);
        }
        value = JSON.stringify(value);
        if (this.base64) {
            value = Base64.encode(value);
        }
        this.local.setItem(key, value);
    }
    remove(key) {
        if (this.prefix) {
            key = this.prefix + '-' + key;
        }
        if (this.base64) {
            key = Base64.encode(key);
        }
        this.local.removeItem(key);
    }
    /**
     * 使用 【Storage缓存数据】 为 【数据对象】初始化
     * @param {String} key 缓存Key
     * @param {Object} data 初始数据
     */
    initWithKey(key, data) {
        const value = this.get(key);
        if (value) {
            Object.keys(value).forEach(field => {
                data[field] = value[field];
            });
        } else {
            this.set(key, data);
        }
        return data;
    }
    /**
     * 使用 【Storage缓存数据】 为 【数据对象】初始化
     * 扫描 数据对象的 属性，为每个属性分别获取缓存并赋值
     * @param {Object} data 初始数据
     */
    init(data) {
        Object.keys(data).forEach(key => {
            const value = this.get(key);
            if (value) {
                if (!data[key]) {
                    data[key] = value;
                } else {
                    Object.keys(value).forEach(field => {
                        data[key][field] = value[field];
                    });
                }
            } else {
                this.set(key, data[key]);
            }
        });
        return data;
    }
    install(Vue) {
        if (Vue && Vue.prototype) {
            Vue.prototype['$'+this.name] = this;
        }
    }
}

const $debug = process.env.NODE_ENV == 'development';
const $storage = new StorageImpl('storage', window.localStorage || new DefaultSrorage('localStorage'), !$debug);
const $session = new StorageImpl('session', window.sessionStorage || new DefaultSrorage('sessionStorage'), !$debug);

export const Storage = $storage;
export const Session = $session;
export default Object.assign(new StorageImpl('storage', window.localStorage || new DefaultSrorage('localStorage'), !$debug), {
    Storage,Session,
    install(Vue, op) {
        if (Vue && Vue.prototype) {
            Vue.prototype.$storage = $storage;
            Vue.prototype.$session = $session;
        }
        if (op) {
            this.prefix = op.prefix || this.prefix;
            $storage.prefix = op.prefix || $storage.prefix;
            $session.prefix = op.prefix || $session.prefix;
        }
    },
})
