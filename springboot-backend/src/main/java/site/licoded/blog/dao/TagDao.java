package site.licoded.blog.dao;

import site.licoded.blog.entity.Tag;

import java.util.List;

public interface TagDao {
    List<String> getAllTagName();
    List<Integer> getPidListByTag(String tagName);
    List<String> getTagListByPid(Integer pid);
    Boolean existTagRecord(Tag tag);
    void addTagRecord(Tag tag);
    void clearTagByPid(Integer pid);
}
