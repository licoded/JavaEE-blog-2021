package site.licoded.blog.controller;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import site.licoded.blog.config.MyException;
import site.licoded.blog.config.PassToken;
import site.licoded.blog.entity.User;
import site.licoded.blog.enums.ResponseEnum;
import site.licoded.blog.resp.ErrorResponse;
import site.licoded.blog.resp.Response;
import site.licoded.blog.resp.SuccessResponse;
import site.licoded.blog.service.TokenService;
import site.licoded.blog.service.UserService;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/user")
public class UserController {
    @Resource
    UserService userService;

    @PassToken
    @RequestMapping (value = "/token", produces = "application/json;charset=UTF-8")
    public Response getToken(@RequestBody User _user){
        User user = userService.checkUser(_user);
        if(user==null){
            throw new MyException(ResponseEnum.USER_NOT_FOUND);
        }
        Map<String,Object> map = new HashMap<>();
        map.put("token", TokenService.getToken(user));
        map.put("userId",user.getId());
        map.put("username",user.getUsername());
        map.put("role",user.getRole());
        map.put("avatar",user.getAvatar());
        return new SuccessResponse(map);
    }

    @PassToken
    @RequestMapping (value = "/register", produces = "application/json;charset=UTF-8")
    public Response register(@RequestBody User _user){
        User user = userService.checkUser(_user);
        if(user!=null){
            return new ErrorResponse("用户已存在！");
        }
        userService.addUser(_user);
        return new SuccessResponse("注册成功！");
    }
}
