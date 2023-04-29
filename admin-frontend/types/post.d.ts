interface IPostItem{
	id:number;
	title: string;
	date:string;
	summary: string;
}

interface IPostItemPage{
	total: number;
	pages: number;
	records: Array<IPostItem>
}

interface IPostAdmin {
	id: number;
	title: string;
	date: string;
	content: string;
	summary: string;
	published: boolean;
	tags: Array<string>;
}