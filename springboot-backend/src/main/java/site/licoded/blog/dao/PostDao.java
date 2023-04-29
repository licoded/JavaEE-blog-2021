package site.licoded.blog.dao;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import site.licoded.blog.entity.Post;

import java.util.List;

public interface PostDao {
    Post addPost(Post post);
    Post getPostById(Integer postId);
    Page<Post> list(Page<Post> page);
    Page<Post> listDetail(Page<Post> page);
    List<Post> listAllPublishedDetail();
    Page<Post> listPublishedDetail(Page<Post> page);
    void editPostById(Post post);
    void setSate(List<Integer> pidList, Boolean flag);
    void deleteList(List<Integer> pidList);
    List<Post> getPostListByPidList(List<Integer> pidList);
    void setPost(Post post);
}
