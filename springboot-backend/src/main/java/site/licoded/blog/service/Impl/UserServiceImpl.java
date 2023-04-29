package site.licoded.blog.service.Impl;

import org.springframework.stereotype.Service;
import site.licoded.blog.dao.UserDao;
import site.licoded.blog.entity.User;
import site.licoded.blog.service.UserService;

import javax.annotation.Resource;

@Service
public class UserServiceImpl implements UserService {
    @Resource
    UserDao userDao;

    @Override
    public User findUserById(Integer userId) {
        return userDao.findUserById(userId);
    }

    @Override
    public User checkUser(User user) {
        return userDao.checkUser(user.getUsername(), user.getPassword());
    }

    @Override
    public void addUser(User user) {
        userDao.addUser(user.getUsername(), user.getPassword());
    }
}
