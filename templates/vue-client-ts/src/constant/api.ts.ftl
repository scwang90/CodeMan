export type HTTP_METHOD = 'GET' | 'POST' | 'PUT' | 'DELETE';

export interface Page {
    size:number
    page?:number
    skip?:number
}

export interface SearchKey {
    key: string
}

export interface Result<T> {
    code: number
    message: string
    result: T
}

export interface Paged<T> {
    list: Array<T>
    total: number
}
