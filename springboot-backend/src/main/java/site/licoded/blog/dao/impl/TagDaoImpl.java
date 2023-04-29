package site.licoded.blog.dao.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.stereotype.Service;
import site.licoded.blog.dao.TagDao;
import site.licoded.blog.entity.Tag;
import site.licoded.blog.mapper.TagMapper;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Service
public class TagDaoImpl implements TagDao {
    @Resource
    TagMapper tagMapper;
    @Override
    public List<String> getAllTagName() {
        QueryWrapper<Tag> queryWrapper = new QueryWrapper<>();
        queryWrapper.select("DISTINCT name");
        List<Tag> tagList = tagMapper.selectList(queryWrapper);
        List<String> tagNameList = new ArrayList<>();
        for (int i = 0; i < tagList.size(); i++) {
            tagNameList.add(tagList.get(i).getName());
        }
        return tagNameList;
    }

    @Override
    public List<Integer> getPidListByTag(String tagName) {
        QueryWrapper<Tag> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("name", tagName);
        queryWrapper.select("pid");
        List<Tag> tagList = tagMapper.selectList(queryWrapper);
        List<Integer> pidList = new ArrayList<>();
        for (int i = 0; i < tagList.size(); i++) {
            pidList.add(tagList.get(i).getPid());
        }
        return pidList;
    }

    @Override
    public List<String> getTagListByPid(Integer pid) {
        QueryWrapper<Tag> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("pid", pid);
        queryWrapper.select("name");
        List<Tag> tagList = tagMapper.selectList(queryWrapper);
        List<String> tagNameList = new ArrayList<>();
        for (int i = 0; i < tagList.size(); i++) {
            tagNameList.add(tagList.get(i).getName());
        }
        return tagNameList;
    }

    @Override
    public Boolean existTagRecord(Tag tag) {
        QueryWrapper<Tag> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("pid", tag.getPid());
        queryWrapper.eq("name", tag.getName());
        Tag _tag = tagMapper.selectOne(queryWrapper);
        return _tag!=null;
    }

    @Override
    public void addTagRecord(Tag tag) {
        tagMapper.insert(tag);
    }

    @Override
    public void clearTagByPid(Integer pid) {
        QueryWrapper<Tag> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("pid", pid);
        tagMapper.delete(queryWrapper);
    }
}
