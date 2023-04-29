package site.licoded.blog.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import site.licoded.blog.entity.Tag;

@Mapper
public interface TagMapper extends BaseMapper<Tag> {
}
