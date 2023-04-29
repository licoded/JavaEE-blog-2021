package site.licoded.blog.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import site.licoded.blog.config.PassToken;
import site.licoded.blog.entity.Post;
import site.licoded.blog.resp.Response;
import site.licoded.blog.resp.SuccessResponse;
import site.licoded.blog.service.PostService;
import site.licoded.blog.service.TagService;
import site.licoded.blog.vo.PidListParam;
import site.licoded.blog.vo.PostEditParam;
import site.licoded.blog.vo.SetStateParam;
import site.licoded.blog.vo.page.PageParam;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/post")
public class PostController {
    @Resource
    PostService postService;
    @Resource
    TagService tagService;

    @PassToken
    @RequestMapping(value = "/{id}", produces = "application/json;charset=UTF-8")
    Response getPostById(@PathVariable(name = "id")Integer id) {
        Post post = postService.getPostById(id);
        post.setReadNum(post.getReadNum()+ 1);
        postService.setPost(post);
        List<String> tagList = tagService.getTagListByPid(id);
        Map<String, Object> map = new HashMap<>();
        map.put("id", post.getId());
        map.put("title", post.getTitle());
        map.put("content", post.getContent());
        map.put("date", post.getDate());
        map.put("published", post.getPublished());
        map.put("summary", post.getSummary());
        map.put("tags", tagList);
        map.put("readNum", post.getReadNum());
        return new SuccessResponse(map);
    }

    @PassToken
    @RequestMapping(value = "/edit", produces = "application/json;charset=UTF-8")
    Response editPostById(@RequestBody PostEditParam postEditParam) {
        postService.editPostById(postEditParam.getPost());
        tagService.setTagList(postEditParam.getTagList(), postEditParam.getId());
        return new SuccessResponse("ok");
    }

    @PassToken
    @RequestMapping(value = "/add", produces = "application/json;charset=UTF-8")
    Response addPost(@RequestBody PostEditParam postEditParam) {
        Post post = postService.addPost(postEditParam.getPost());
        postEditParam.setId(post.getId());
        tagService.setTagList(postEditParam.getTagList(), postEditParam.getId());
        return new SuccessResponse(post.getId());
    }

    // TODO:后面要去掉PassToken
    @PassToken
    @RequestMapping(value = "/list", produces = "application/json;charset=UTF-8")
    Response list(@RequestBody PageParam pageParam){
        Page<Post> page = new Page<>(pageParam.getPage(), pageParam.getPageSize());
        return new SuccessResponse(postService.list(page));
    }

    @PassToken
    @RequestMapping(value = "/listDetail", produces = "application/json;charset=UTF-8")
    Response listDetail(@RequestBody PageParam pageParam){
        Page<Post> page = new Page<>(pageParam.getPage(), pageParam.getPageSize());
        return new SuccessResponse(postService.listDetail(page));
    }

    @PassToken
    @RequestMapping(value = "/listPublishedDetail", produces = "application/json;charset=UTF-8")
    Response listPublishedDetail(@RequestBody PageParam pageParam){
        Page<Post> page = new Page<>(pageParam.getPage(), pageParam.getPageSize());
        return new SuccessResponse(postService.listPublishedDetail(page));
    }

    @PassToken
    @RequestMapping(value = "/listAllPublishedDetail", produces = "application/json;charset=UTF-8")
    Response listAllPublishedDetail(){
        return new SuccessResponse(postService.listAllPublishedDetail());
    }

    @PassToken
    @RequestMapping(value = "/setState", produces = "application/json;charset=UTF-8")
    Response setSate(@RequestBody SetStateParam setStateParam){
        postService.setSate(setStateParam);
        return new SuccessResponse("ok");
    }

    @PassToken
    @RequestMapping(value = "/deleteList", produces = "application/json;charset=UTF-8")
    Response deleteList(@RequestBody PidListParam pidListParam){
        postService.deleteList(pidListParam.getPidList());
        return new SuccessResponse("ok");
    }
}
