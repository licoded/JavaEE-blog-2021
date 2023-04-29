package site.licoded.blog.dao.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.stereotype.Service;
import site.licoded.blog.dao.UserDao;
import site.licoded.blog.entity.User;
import site.licoded.blog.mapper.UserMapper;

import javax.annotation.Resource;

@Service
public class UserDaoImpl implements UserDao {
    @Resource
    UserMapper userMapper;

    @Override
    public User findUserById(Integer userId) {
        return userMapper.selectById(userId);
    }

    @Override
    public User checkUser(String username, String password) {
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("username", username);
        queryWrapper.eq("password", password);
        return userMapper.selectOne(queryWrapper);
    }

    @Override
    public void addUser(String username, String password) {
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        userMapper.insert(user);
    }
}
