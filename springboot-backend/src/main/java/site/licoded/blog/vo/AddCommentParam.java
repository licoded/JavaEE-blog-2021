package site.licoded.blog.vo;

import lombok.Data;

@Data
public class AddCommentParam {
    Integer pid;
    String msg;
    Integer cid;
    String uname;
    String avatar;
}
