interface IComment {
  id: string;
  postId: string;
  isChild: boolean;
  commentId?: string;
  toId?: string;
  toName?: string;
  date: string;
  fromId: string;
  fromName: string;
  fromAvatar: string;
  content: string;
  isLike: boolean;
  likeNum: number;
  reply?: Array<IComment>;
}
