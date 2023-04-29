interface IComment {
  id: number;
  uname: string;
  tname?: string;
  date: string;
  avatar: string;
  msg: string;
  favors: number;
  children?: Array<IComment>;
}
