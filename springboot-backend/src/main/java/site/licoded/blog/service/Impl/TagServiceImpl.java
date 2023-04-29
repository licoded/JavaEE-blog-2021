package site.licoded.blog.service.Impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.parsing.Problem;
import org.springframework.stereotype.Service;
import site.licoded.blog.dao.PostDao;
import site.licoded.blog.dao.TagDao;
import site.licoded.blog.entity.Post;
import site.licoded.blog.entity.Tag;
import site.licoded.blog.mapper.PostTagMapper;
import site.licoded.blog.service.TagService;
import site.licoded.blog.vo.PostTag;
import site.licoded.blog.vo.TagPostList;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

@Service
public class TagServiceImpl implements TagService {
    @Resource
    TagDao tagDao;
    @Resource
    PostDao postDao;
    @Autowired
    PostTagMapper postTagMapper;
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

    @Override
    public List<TagPostList> getTagPostListArr() {
        List<PostTag> postListGroupByTag = postTagMapper.getPostListGroupByTag();
        postListGroupByTag.sort((o1, o2) -> {
            if(Objects.equals(o1.getTagId(), o2.getTagId())) {
                return o1.getPostDate().compareTo(o2.getPostDate());
            }
            return o1.getTagId().compareTo(o2.getTagId());
        });
        Map<String, List<PostTag>> collectByTag = postListGroupByTag
                .stream()
                .collect( Collectors.groupingBy(PostTag::getTagName) );
        List<TagPostList> tagPostListArr = collectByTag.entrySet().stream()
                .map(e -> {
                    List<PostTag> postTagList = e.getValue();
                    PostTag firstOne = postTagList.get(0);
                    List<Post> postList = postTagList
                            .stream()
                            .map(p -> new Post(
                                    p.getPostId(), p.getPostTitle(), null, null, null, null, p.getPostDate()
                            ))
                            .collect(Collectors.toList());
                    return new TagPostList(firstOne.getTagId(), firstOne.getTagName(), postList);
                }).collect(Collectors.toList());
        return tagPostListArr;
    }
}
