package site.licoded.blog.dao.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.stereotype.Service;
import site.licoded.blog.dao.CommentDao;
import site.licoded.blog.entity.Comment;
import site.licoded.blog.mapper.CommentMapper;

import javax.annotation.Resource;
import java.util.List;

@Service
public class CommentDaoImpl implements CommentDao {
    @Resource
    CommentMapper commentMapper;
    @Override
    public List<Comment> getPostCommentRootList(Integer pid) {
        QueryWrapper<Comment> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("pid", pid);
        queryWrapper.eq("fid", -1);
        queryWrapper.orderByAsc("date");
        return commentMapper.selectList(queryWrapper);
    }

    @Override
    public List<Comment> getChildComment(Integer fid) {
        QueryWrapper<Comment> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("fid", fid);
        queryWrapper.orderByAsc("date");
        queryWrapper.select("id", "uname", "tname", "date", "msg", "favors", "avatar");
        return commentMapper.selectList(queryWrapper);
    }

    @Override
    public Comment getCommentById(Integer commentId) {
        QueryWrapper<Comment> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("id", commentId);
        return commentMapper.selectOne(queryWrapper);
    }

    @Override
    public void setCommentFavor(Integer commentId, Integer favorNum) {
        QueryWrapper<Comment> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("id", commentId);
        Comment comment = new Comment();
        comment.setFavors(favorNum);
        commentMapper.update(comment, queryWrapper);
    }

    @Override
    public void addComment(Comment comment) {
        commentMapper.insert(comment);
    }

    @Override
    public void updateAvatar(String uname, String avatar) {
        QueryWrapper<Comment> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("uname", uname);
        Comment comment = new Comment();
        comment.setAvatar(avatar);
        commentMapper.update(comment, queryWrapper);
    }

    @Override
    public List<Comment> getAllComment() {
        QueryWrapper<Comment> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("date");
        return commentMapper.selectList(queryWrapper);
    }

    @Override
    public void deleteList(List<Integer> cidList) {
        QueryWrapper<Comment> queryWrapper = new QueryWrapper<>();
        queryWrapper.in("id", cidList);
        commentMapper.delete(queryWrapper);
    }
}
