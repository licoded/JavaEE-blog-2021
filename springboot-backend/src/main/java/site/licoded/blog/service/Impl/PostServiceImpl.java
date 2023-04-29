package site.licoded.blog.service.Impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.stereotype.Service;
import site.licoded.blog.dao.PostDao;
import site.licoded.blog.entity.Post;
import site.licoded.blog.service.PostService;
import site.licoded.blog.vo.SetStateParam;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class PostServiceImpl implements PostService {
    @Resource
    PostDao postDao;

    @Override
    public Post addPost(Post post) {
        return postDao.addPost(post);
    }

    @Override
    public Post getPostById(Integer postId) {
        return postDao.getPostById(postId);
    }

    @Override
    public Map<String, Object> list(Page<Post> page) {
        Page<Post> PostPage = postDao.list(page);
        Map<String,Object> map = new HashMap<>();
        map.put("records", PostPage.getRecords());
        map.put("total", PostPage.getTotal());
        map.put("pages", PostPage.getPages());
        return map;
    }

    @Override
    public Map<String, Object> listDetail(Page<Post> page) {
        Page<Post> PostPage = postDao.listDetail(page);
        Map<String,Object> map = new HashMap<>();
        map.put("records", PostPage.getRecords());
        map.put("total", PostPage.getTotal());
        map.put("pages", PostPage.getPages());
        return map;
    }

    @Override
    public List<Post> listAllPublishedDetail() {
        return postDao.listAllPublishedDetail();
    }

    @Override
    public Map<String, Object> listPublishedDetail(Page<Post> page) {
        Page<Post> PostPage = postDao.listPublishedDetail(page);
        Map<String,Object> map = new HashMap<>();
        map.put("records", PostPage.getRecords());
        map.put("total", PostPage.getTotal());
        map.put("pages", PostPage.getPages());
        return map;
    }

    @Override
    public void editPostById(Post post) {
        postDao.editPostById(post);
    }

    @Override
    public void setSate(SetStateParam setStateParam) {
        postDao.setSate(setStateParam.getPidList(), setStateParam.getPublished());
    }

    @Override
    public void deleteList(List<Integer> pidList) {
        postDao.deleteList(pidList);
    }

    @Override
    public void setPost(Post post) {
        postDao.setPost(post);
    }
}
