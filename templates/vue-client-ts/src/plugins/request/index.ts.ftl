import Vue from "Vue"
import * as Api from '@/constant/api'

function request<T>(method: Api.HTTP_METHOD, url: string, data?: any): Promise<T> {
    let headers: HeadersInit = {};
    let body: any = data;
    if (method == 'GET' && data && !(data instanceof String)) {
        Object.keys(data).forEach(key=>{
            if (url.indexOf('?')) {
                url = ${r"`${url}&${key}=${data[key]}`"};
            } else {
                url = ${r"`${url}?${key}=${data[key]}`"};
            }
        });
        body = undefined;
    } else if (body && !(body instanceof String) && !(body instanceof FormData)) {
        body = JSON.stringify(body);
        headers['Content-Type'] = 'application/json;charset=UTF-8';
    }
    return fetch(url, {
        method,
        headers,
        body
    }).then(res=>{ return res.json()});
}

function requestLogic<T>(method: Api.HTTP_METHOD, url: string, data?: any): Promise<T> {
    return request<Api.Result<T>>(method, url, data).then(res=>{
        if (res.code != 0 && res.code != 200) {
            throw new Error(res.message);
        }
        return res.result;
    });
}

export type VueType = typeof Vue;

export default {
    get<T>(path: string, data?: any): Promise<T> {
        return requestLogic<T>('GET', path, {params: data});
    },
    post<T>(path: string, data?: any): Promise<T> {
        return request<T>('POST', path, data);
    },
    put<T>(path: string, data?: any): Promise<T> {
        return request<T>('PUT', path, data);
    },
    delete<T>(path: string, data?: any): Promise<T> {
        return request<T>('DELETE', path, {params: data});
    },
    install(Vue: VueType) {
        if (Vue && Vue.prototype) {
            Vue.prototype.$request = this;
        }
    }
}

