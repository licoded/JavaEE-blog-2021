package site.licoded.blog.dao;


import site.licoded.blog.entity.User;

public interface UserDao {
    User findUserById(Integer userId);
    User checkUser(String username, String password);
    void addUser(String username, String password);
}
