package site.licoded.blog.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import site.licoded.blog.config.PassToken;
import site.licoded.blog.resp.Response;
import site.licoded.blog.resp.SuccessResponse;

@RestController
@RequestMapping("/test")
public class TestController {
    @PassToken
    @RequestMapping("/test")
    Response test(){
        return new SuccessResponse("test");
    }
}
