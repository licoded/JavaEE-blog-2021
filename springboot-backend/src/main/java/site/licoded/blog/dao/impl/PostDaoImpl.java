package site.licoded.blog.dao.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.stereotype.Service;
import site.licoded.blog.dao.PostDao;
import site.licoded.blog.entity.Post;
import site.licoded.blog.mapper.PostMapper;

import javax.annotation.Resource;
import java.util.List;

@Service
public class PostDaoImpl implements PostDao {
    @Resource
    PostMapper postMapper;

    @Override
    public Post addPost(Post post) {
        postMapper.insert(post);
        return post;
    }

    @Override
    public Post getPostById(Integer postId) {
        return postMapper.selectById(postId);
    }

    @Override
    public Page<Post> list(Page<Post> page) {
        QueryWrapper<Post> queryWrapper = new QueryWrapper<>();
        queryWrapper.select("id", "title", "date");
        queryWrapper.orderByDesc("date");
        return postMapper.selectPage(page, queryWrapper);
    }

    @Override
    public Page<Post> listDetail(Page<Post> page) {
        QueryWrapper<Post> queryWrapper = new QueryWrapper<>();
        queryWrapper.select("id", "title", "date", "summary", "published");
        queryWrapper.orderByDesc("date");
        return postMapper.selectPage(page, queryWrapper);
    }

    @Override
    public List<Post> listAllPublishedDetail() {
        QueryWrapper<Post> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("published", true);
        queryWrapper.select("id", "title", "date");
        queryWrapper.orderByDesc("date");
        return postMapper.selectList(queryWrapper);
    }

    @Override
    public Page<Post> listPublishedDetail(Page<Post> page) {
        QueryWrapper<Post> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("published", true);
        queryWrapper.select("id", "title", "date", "summary");
        queryWrapper.orderByDesc("date");
        return postMapper.selectPage(page, queryWrapper);
    }

    @Override
    public void editPostById(Post post) {
        postMapper.updateById(post);
    }

    @Override
    public void setSate(List<Integer> pidList, Boolean flag) {
        QueryWrapper<Post> queryWrapper = new QueryWrapper<>();
        queryWrapper.in("id", pidList);
        Post post = new Post();
        post.setPublished(flag);
        postMapper.update(post, queryWrapper);
    }

    @Override
    public void deleteList(List<Integer> pidList) {
        QueryWrapper<Post> queryWrapper = new QueryWrapper<>();
        queryWrapper.in("id", pidList);
        postMapper.delete(queryWrapper);
    }

    @Override
    public List<Post> getPostListByPidList(List<Integer> pidList) {
        QueryWrapper<Post> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("published", true);
        queryWrapper.in("id", pidList);
        queryWrapper.select("id","title");
        return postMapper.selectList(queryWrapper);
    }

    @Override
    public void setPost(Post post) {
        postMapper.updateById(post);
    }
}
