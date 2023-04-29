package site.licoded.blog.controller;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import site.licoded.blog.config.PassToken;
import site.licoded.blog.entity.Post;
import site.licoded.blog.resp.Response;
import site.licoded.blog.resp.SuccessResponse;
import site.licoded.blog.service.TagService;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/tag")
public class TagController {
    @Resource
    TagService tagService;

    @PassToken
    @RequestMapping(value = "/{id}", produces = "application/json;charset=UTF-8")
    Response getPostById(@PathVariable(name = "id")Integer id) {
        List<String> tagList = tagService.getTagListByPid(id);
        return new SuccessResponse(tagList);
    }

    @PassToken
    @RequestMapping(value = "/list")
    Response list() {
        List<String> tagList = tagService.getAllTagName();
        return new SuccessResponse(tagList);
    }

    @PassToken
    @RequestMapping(value = "/getPostListByTag/{tagName}", produces = "application/json;charset=UTF-8")
    Response getPostListByTag(@PathVariable(name = "tagName")String tagName) {
        List<Post> postList = tagService.getPostListByTag(tagName);
        return new SuccessResponse(postList);
    }
}
