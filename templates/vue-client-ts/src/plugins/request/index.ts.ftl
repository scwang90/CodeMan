import Vue from "Vue"
import * as Api from '@/constant/api'

let $baseUrl = '';

function request(method: Api.HTTP_METHOD, url: string, data?: any, headers: Record<string, string> = {}): Promise<Response> {
    
    let body: any = data;
    if (method == 'GET' && data && !(data instanceof String)) {
        Object.keys(data).forEach(key=>{
            if (url.indexOf('?') > 0) {
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
    return fetch($baseUrl + url, {
        method,
        headers,
        body
    });
}

async function requestJson<T>(method: Api.HTTP_METHOD, url: string, data?: any, headers: Record<string, string> = {}): Promise<T> {
    if (!headers.Accept) {
        headers.Accept = 'application/json';
    }

    const bearer = sessionStorage.getItem(`Bearer`);
    if (bearer && !headers.Authorization) {
        headers.Authorization = ${r"`Bearer ${bearer}`"};
    }

    const response = await request(method, url, data, headers);

    const token = response.headers.get('x-auth-token');
    if (token) {
        sessionStorage.setItem('Bearer', token);
    }
    try {
        return await response.json();
    } catch (error) {
        if (response.ok) {
            throw new Error(${r"`服务器返回非JSON信息:${await response.text()}`"});
        } else {
            throw new Error(${r"`${response.status} ${response.statusText}`"});
        }
    }
}

async function requestLogic<T>(method: Api.HTTP_METHOD, url: string, data?: any): Promise<T> {
    const result = await requestJson<Api.Result<T>>(method, url, data, {});
    if (result.code != 0 && result.code != 200) {
        throw new Error(result.message);
    } else {
        return result.result;
    }
}

export type VueType = typeof Vue;

export default {
    get<T>(path: string, data?: any): Promise<T> {
        return requestLogic<T>('GET', path, data);
    },
    post<T>(path: string, data?: any): Promise<T> {
        return requestLogic<T>('POST', path, data);
    },
    put<T>(path: string, data?: any): Promise<T> {
        return requestLogic<T>('PUT', path, data);
    },
    delete<T>(path: string, data?: any): Promise<T> {
        return requestLogic<T>('DELETE', path, data);
    },
    install(Vue: VueType, { baseUrl }: { baseUrl: string}) {
        if (Vue && Vue.prototype) {
            Vue.prototype.$request = this;
        }
        if (baseUrl) {
            $baseUrl = baseUrl;
        }
    }
}


