interface IApi{
    [index: string]: string; 
}

interface IParamLogin{
    username: string;
    password: string;
}

interface IParamPage{
	page?: number;
	pageSize?: number;
}

interface IParamSetState{
    pidList: Array<number>;
    published: boolean;
}

interface IParamPidList{
    pidList: Array<number>;
}

interface IParamCidList{
    cidList: Array<number>;
}