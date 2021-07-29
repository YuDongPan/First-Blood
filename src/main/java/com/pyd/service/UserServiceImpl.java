package com.pyd.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pyd.dao.UserMapper;
import com.pyd.dbutil.MyBatisUtil;
import com.pyd.entity.User;

@Service("userService")
public class UserServiceImpl implements UserService{
	@Autowired
	private UserMapper userMapper;
	
	@Override
	public int addUser(User user) {
		return userMapper.addUser(user); 	
	}
	
    @Override
	public List<User> queryAllUser() {          
	     return userMapper.queryAllUser();  
	}
    
    @Override
	public User queryUserByNP(User user) {    
		return userMapper.queryUserByNP(user);
	}
    
    @Override
   	public User queryUserByTP(User user) {    
   		return userMapper.queryUserByTP(user);
   	}
    
    @Override
	public int updateUser(User user) {
		return userMapper.updateUser(user);
	}

	@Override
	public User queryUserByName(String username) {
		// TODO 自动生成的方法存根
		return userMapper.queryUserByName(username);
	}
    
	@Override
	public User queryUserByTel(String phonenumber) {
		// TODO 自动生成的方法存根
		return userMapper.queryUserByTel(phonenumber);
	}
	@Override
	public User queryUserByEmail(String email) {
		// TODO 自动生成的方法存根
		return userMapper.queryUserByEmail(email);
	}

	@Override
	public User queryUserByIU(User user) {
		// TODO 自动生成的方法存根
		return userMapper.queryUserByIU(user);
	}

	@Override
	public User queryUserByIdentification(String identification) {
		// TODO 自动生成的方法存根
		return userMapper.queryUserByIdentification(identification);
	}


}
