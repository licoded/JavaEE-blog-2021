package site.licoded.blog.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import site.licoded.blog.entity.Post;
import site.licoded.blog.vo.SetStateParam;

import java.util.List;
import java.util.Map;

public interface PostService {
    Post addPost(Post post);
    Post getPostById(Integer postId);
    Map<String, Object> list(Page<Post> page);
    Map<String, Object> listDetail(Page<Post> page);
    List<Post> listAllPublishedDetail();
    Map<String, Object> listPublishedDetail(Page<Post> page);
    void editPostById(Post post);
    void setSate(SetStateParam setStateParam);
    void deleteList(List<Integer> pidList);
    void setPost(Post post);
}
