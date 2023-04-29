package site.licoded.blog.service.Impl;

import org.springframework.beans.factory.parsing.Problem;
import org.springframework.stereotype.Service;
import site.licoded.blog.dao.PostDao;
import site.licoded.blog.dao.TagDao;
import site.licoded.blog.entity.Post;
import site.licoded.blog.entity.Tag;
import site.licoded.blog.service.TagService;

import javax.annotation.Resource;
import java.util.List;

@Service
public class TagServiceImpl implements TagService {
    @Resource
    TagDao tagDao;
    @Resource
    PostDao postDao;
    @Override
    public List<String> getAllTagName() {
        return tagDao.getAllTagName();
    }

    @Override
    public void addTagRecord(Tag tag) {
        if (!tagDao.existTagRecord(tag)) {
            tagDao.addTagRecord(tag);
        }
    }

    @Override
    public void setTagList(List<Tag> tagList, Integer pid) {
        tagDao.clearTagByPid(pid);
        for (int i = 0; i < tagList.size(); i++) {
            Tag tag = tagList.get(i);
            if (!tagDao.existTagRecord(tag)) {
                tagDao.addTagRecord(tag);
            }
        }
    }

    @Override
    public List<String> getTagListByPid(Integer pid) {
        return tagDao.getTagListByPid(pid);
    }

    @Override
    public List<Post> getPostListByTag(String tagName) {
        List<Integer> pidList = tagDao.getPidListByTag(tagName);
        return postDao.getPostListByPidList(pidList);
    }
}
