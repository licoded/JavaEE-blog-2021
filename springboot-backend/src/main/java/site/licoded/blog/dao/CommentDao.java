package site.licoded.blog.dao;

import site.licoded.blog.entity.Comment;

import java.util.List;

public interface CommentDao {
    List<Comment> getPostCommentRootList(Integer pid);
    List<Comment> getChildComment(Integer fid);
    Comment getCommentById(Integer commentId);
    void setCommentFavor(Integer commentId, Integer favorNum);
    void addComment(Comment comment);
    void updateAvatar(String uname, String avatar);
    List<Comment> getAllComment();
    void deleteList(List<Integer> cidList);
}
