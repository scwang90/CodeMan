
export interface Page {
    size:number
    page?:number
    skip?:number
}

export interface Result<T> {
    code: number
    message: string
    result: T
}

export interface Paged<T> {
    list: Array<T>
    totalRecord: number
}
