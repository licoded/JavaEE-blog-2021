export function sleep<T=any>(t:number, data:T):Promise<T>{
    return new Promise(resolve=>{
        setTimeout(()=>{
            resolve(data);
        }, t);
    })
}