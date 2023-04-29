package site.licoded.blog.service;

import site.licoded.blog.entity.Post;
import site.licoded.blog.entity.Tag;
import site.licoded.blog.vo.TagPostList;

import java.util.List;

public interface TagService {
    List<String> getAllTagName();
    void addTagRecord(Tag tag);
    void setTagList(List<Tag> tagList, Integer pid);
    List<String> getTagListByPid(Integer pid);
    List<Post> getPostListByTag(String tagName);
    List<TagPostList> getTagPostListArr();
}
