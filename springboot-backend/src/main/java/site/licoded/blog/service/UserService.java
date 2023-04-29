package site.licoded.blog.service;

import site.licoded.blog.entity.User;

public interface UserService {
    User findUserById(Integer userId);
    public User checkUser(User user);
    public void addUser(User user);
}
