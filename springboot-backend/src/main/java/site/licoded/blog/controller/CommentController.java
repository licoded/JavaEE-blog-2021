package site.licoded.blog.controller;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import site.licoded.blog.config.PassToken;
import site.licoded.blog.entity.Comment;
import site.licoded.blog.entity.Post;
import site.licoded.blog.resp.Response;
import site.licoded.blog.resp.SuccessResponse;
import site.licoded.blog.service.CommentService;
import site.licoded.blog.vo.AddCommentParam;
import site.licoded.blog.vo.CidListParam;
import site.licoded.blog.vo.PidListParam;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/comment")
public class CommentController {
    @Resource
    CommentService commentService;

    @PassToken
    @RequestMapping(value = "/{pid}", produces = "application/json;charset=UTF-8")
    Response getPostById(@PathVariable(name = "pid")Integer pid) {
        List<Map<String,Object>> mapList = commentService.getPostCommentList(pid);
        return new SuccessResponse(mapList);
    }

    @PassToken
    @RequestMapping(value = "/addFavor/{cid}", produces = "application/json;charset=UTF-8")
    Response addCommentFavor(@PathVariable(name = "cid")Integer cid) {
        commentService.addCommentFavor(cid);
        return new SuccessResponse("ok");
    }

    @PassToken
    @RequestMapping(value = "/subFavor/{cid}", produces = "application/json;charset=UTF-8")
    Response subCommentFavor(@PathVariable(name = "cid")Integer cid) {
        commentService.subCommentFavor(cid);
        return new SuccessResponse("ok");
    }

    @PassToken
    @RequestMapping(value = "/list", produces = "application/json;charset=UTF-8")
    Response list() {
        List<Map<String,Object>> allComment = commentService.getAllComment();
        return new SuccessResponse(allComment);
    }

    @PassToken
    @RequestMapping(value = "/addComment", produces = "application/json;charset=UTF-8")
    Response addComment(@RequestBody AddCommentParam addCommentParam) {
        Integer pid = addCommentParam.getPid();
        String msg = addCommentParam.getMsg();
        Integer cid = addCommentParam.getCid();
        String uname = addCommentParam.getUname();
        String avatar = addCommentParam.getAvatar();
        Comment comment = commentService.getCommentById(cid);
        commentService.addComment(pid, uname, avatar, msg, comment);
        return new SuccessResponse("ok");
    }

    @PassToken
    @RequestMapping(value = "/deleteList", produces = "application/json;charset=UTF-8")
    Response deleteList(@RequestBody CidListParam cidListParam){
        commentService.deleteList(cidListParam.getCidList());
        return new SuccessResponse("ok");
    }
}
