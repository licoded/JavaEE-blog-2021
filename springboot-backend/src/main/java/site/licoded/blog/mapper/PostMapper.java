package site.licoded.blog.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import site.licoded.blog.entity.Post;

@Mapper
public interface PostMapper extends BaseMapper<Post> {
}
