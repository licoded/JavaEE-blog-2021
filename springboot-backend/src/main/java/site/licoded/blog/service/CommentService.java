package site.licoded.blog.service;

import site.licoded.blog.entity.Comment;

import java.util.List;
import java.util.Map;

public interface CommentService {
    List<Map<String,Object>> getPostCommentList(Integer pid);
    void addCommentFavor(Integer commentId);
    void subCommentFavor(Integer commentId);
    void addComment(Integer pid, String uname, String avatar, String msg, Comment father);
    Comment getCommentById(Integer cid);
    List<Map<String,Object>> getAllComment();
    void deleteList(List<Integer> cidList);
}
