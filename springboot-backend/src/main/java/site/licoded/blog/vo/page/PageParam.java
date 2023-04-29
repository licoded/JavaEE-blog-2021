package site.licoded.blog.vo.page;

import lombok.Data;

@Data
public class PageParam {
    private Long page = 1L;
    private Long pageSize = 15L;
}
