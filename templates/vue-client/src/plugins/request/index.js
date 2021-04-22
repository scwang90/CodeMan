import Vue from "Vue"
import VueResource from "vue-resource"
Vue.use(VueResource);

Vue.http.options.emulateJSON = true
// Vue.http.options.root = process.env.SETTING_API_BASE;
Vue.http.options.xhr = { withCredentials: true };
Vue.http.interceptors.push(function(request, next) {

    request.withCredentials = true;
    // modify method
    // request.method = 'POST';

    // modify headers
    // request.headers.set('X-CSRF-TOKEN', 'TOKEN');
    // request.headers.set('Authorization', 'Bearer TOKEN');
    
    // console.log('start', request);
    if (Vue.http.options.hookResponse) {
        next(response => {
            Vue.http.options.hookResponse(response)
        })
    }
});

const request = (method, path, data) => {
    return new Promise((resolve, reject) => {
        Vue.http[method].call(Vue.http, path, data)
        .then(res => {
            if (res.ok) {
                if (res.body.code == 200) {
                    resolve(res.body.result);
                } else {
                    console.warn(res.body.message);
                    reject(res.body.message);
                }
            } else {
                console.error(res);
                reject(JSON.stringify(res));
            }
        }, res => {
            console.error(res);
            if (res.status == 0) {
                reject('网络连接失败!');
            } else {
                reject(JSON.stringify(res));
            }
        });
    });
}

export default {
    get(path, data) {
        return request('get', path, {params: data});
    },
    post(path, data) {
        return request('post', path, data);
    },
    put(path, data) {
        return request('put', path, data);
    },
    delete(path, data) {
        return request('delete', path, {params: data});
    },
    url(path) {
        return Vue.http.options.root.replace(/\/$/,'') + '/' + path;
    },
    install(Vue, op = {}) {
        if (Vue && Vue.prototype) {
            Vue.request = this;
            Vue.prototype.$request = this;
            if (op.root && op.root != '/') {
                Vue.http.options.root = op.root;
            }
            if (op.hookResponse instanceof Function) {
                Vue.http.options.hookResponse = op.hookResponse;
            }
        }
    }
}

