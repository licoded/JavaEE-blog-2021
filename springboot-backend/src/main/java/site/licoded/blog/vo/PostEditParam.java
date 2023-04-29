package site.licoded.blog.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;
import site.licoded.blog.entity.Post;
import site.licoded.blog.entity.Tag;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Data
public class PostEditParam {
    private Integer id;

    private String title;
    private String content;
    private String summary;
    private Boolean published;
    private List<String> tags;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone="GMT+8")
    private Date date;

    public Post getPost(){
        Post post = new Post();
        post.setId(id);
        post.setContent(content);
        post.setDate(date);
        post.setPublished(published);
        post.setTitle(title);
        post.setSummary(summary);
        return post;
    }

    public static PostEditParam toPostEditParam(Post post, List<String> tagList){
        PostEditParam postEditParam = new PostEditParam();
        postEditParam.setId(post.getId());
        postEditParam.setContent(post.getContent());
        postEditParam.setDate(post.getDate());
        postEditParam.setPublished(post.getPublished());
        postEditParam.setTitle(post.getTitle());
        postEditParam.setSummary(post.getSummary());
        postEditParam.setTags(tagList);
        return postEditParam;
    }

    public List<Tag> getTagList(){
        List<Tag> tagList = new ArrayList<>();
        if(tags==null) {
            return tagList;
        }
        for (int i = 0; i < tags.size(); i++) {
            Tag tag = new Tag();
            tag.setPid(id);
            tag.setName(tags.get(i));
            tagList.add(tag);
        }
        return tagList;
    }
}
