package site.licoded.blog.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import site.licoded.blog.vo.PostTag;

import java.util.List;

@Mapper
public interface PostTagMapper {
    @Results({
            @Result(property = "tagId", column = "tid"),
            @Result(property = "tagName", column = "name"),
            @Result(property = "postId", column = "pid"),
            @Result(property = "postTitle", column = "title"),
            @Result(property = "postDate", column = "date"),
    })
    @Select("SELECT\n" +
            "    tag.id as tid, tag.name, post.title, post.id as pid, post.date\n" +
            "FROM tag, post\n" +
            "WHERE tag.pid = post.id AND post.published = true;")
    public List<PostTag> getPostListGroupByTag();
}
