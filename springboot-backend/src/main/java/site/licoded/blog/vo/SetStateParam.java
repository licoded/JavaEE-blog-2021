package site.licoded.blog.vo;

import lombok.Data;

import java.util.List;

@Data
public class SetStateParam {
    List<Integer> pidList;
    Boolean published;
}
