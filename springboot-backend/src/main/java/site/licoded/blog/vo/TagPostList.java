package site.licoded.blog.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import site.licoded.blog.entity.Post;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class TagPostList {
    private Integer tagId;
    private String tagName;
    private List<Post> postList;
}
