package site.licoded.blog.service.Impl;

import org.springframework.stereotype.Service;
import site.licoded.blog.dao.CommentDao;
import site.licoded.blog.dao.PostDao;
import site.licoded.blog.entity.Comment;
import site.licoded.blog.service.CommentService;

import javax.annotation.Resource;
import java.util.*;

@Service
public class CommentServiceImpl implements CommentService {
    @Resource
    CommentDao commentDao;
    @Resource
    PostDao postDao;
    @Override
    public List<Map<String,Object>> getPostCommentList(Integer pid) {
        List<Comment> commentList = commentDao.getPostCommentRootList(pid);
        List<Map<String,Object>> mapList = new ArrayList<>();
        for (int i = 0; i < commentList.size(); i++) {
            Comment comment = commentList.get(i);
            List<Comment> children = commentDao.getChildComment(comment.getId());
            Map<String,Object> commentMap = new HashMap<>();
            commentMap.put("id", comment.getId());
            commentMap.put("uname", comment.getUname());
            commentMap.put("date", comment.getDate());
            commentMap.put("msg", comment.getMsg());
            commentMap.put("favors", comment.getFavors());
            commentMap.put("children", children);
            commentMap.put("avatar", comment.getAvatar());
            mapList.add(commentMap);
        }
        return mapList;
    }

    @Override
    public void addCommentFavor(Integer commentId) {
        Comment comment = commentDao.getCommentById(commentId);
        commentDao.setCommentFavor(commentId, comment.getFavors()+1);
    }

    @Override
    public void subCommentFavor(Integer commentId) {
        Comment comment = commentDao.getCommentById(commentId);
        commentDao.setCommentFavor(commentId, comment.getFavors()-1);
    }

    @Override
    public void addComment(Integer pid, String uname, String avatar, String msg, Comment father) {
        Comment comment = new Comment();
        comment.setPid(pid);
        comment.setFid(father==null?-1:(father.getFid()==-1?father.getId():father.getFid()));
        comment.setUname(uname);
        comment.setTname(father==null?null:father.getUname());
//        if(father==null){
//            comment.setFid(-1);
//            comment.setTname(null);
//        }else{
//            comment.setFid(father.getFid());
//            comment.setTname(father.getUname());
//        }
        comment.setDate(new Date());
        comment.setMsg(msg);
        comment.setFavors(0);
        comment.setAvatar(avatar);
        commentDao.updateAvatar(uname, avatar);
        commentDao.addComment(comment);
    }

    @Override
    public Comment getCommentById(Integer cid) {
        return commentDao.getCommentById(cid);
    }

    @Override
    public List<Map<String,Object>> getAllComment() {
        List<Comment> commentList = commentDao.getAllComment();
        List<Map<String,Object>> mapList = new ArrayList<>();
        for (int i = 0; i < commentList.size(); i++) {
            Comment comment = commentList.get(i);
            Map<String,Object> map = new HashMap<>();
            map.put("id", comment.getId());
            map.put("pid", comment.getPid());
            map.put("fid", comment.getFid());
            map.put("uname", comment.getUname());
            map.put("tname", comment.getTname());
            map.put("date", comment.getDate());
            map.put("msg", comment.getMsg());
            map.put("favors", comment.getFavors());
            map.put("avator", comment.getAvatar());
            map.put("post", postDao.getPostById(comment.getPid()).getTitle());
            mapList.add(map);
        }
        return mapList;
    }

    @Override
    public void deleteList(List<Integer> cidList) {
        commentDao.deleteList(cidList);
    }
}
