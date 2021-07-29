package com.pyd.service;

import java.util.List;

import com.pyd.entity.User;

public interface UserService {
	
	
	/**
	 * 根据身份证号查询用户
	 * @author 胡辉
	 * @param identification
	 * @return User
	 * 
	 */
	public User queryUserByIdentification(String identification);
	
	/**
	 * 添加用户
	 * @author 潘昱东、胡辉
	 * @param user
	 * @return 操作是否成功
	 */
	public int addUser(User user);
	
	/**
	 * 查询所有用户
	 * @author 潘昱东
	 * @return 返回结果保存在集合
	 */
	public List<User> queryAllUser();
	

	/**
	 * 根据用户名和用户密码查询单个用户
	 * @author 潘昱东
	 * @return 
	 */
	public User queryUserByNP(User user);
	
	/**
	 * 根据手机号和用户密码查询单个用户
	 * @author 潘昱东
	 * @return 
	 */
	public User queryUserByTP(User user);
   
	/**
	 * 根据用户名查询用户
	 * @author 潘昱东
	 * @param username
	 * @return 查询结果
	 */
	public User queryUserByName(String username);
	
	/**
	 * 根据手机号查询用户
	 * @author 潘昱东
	 * @param phonenumber
	 * @return 查询结果
	 */
	public User queryUserByTel(String phonenumber);
	
	/**
	 * 根据电子邮箱查询用户
	 * @author 潘昱东、胡辉
	 * @param email
	 * @return 查询结果
	 */
	public User queryUserByEmail(String email);
	
	/**
	 * 查找用户
	 * @param user
	 * @author 鄢锦玲
	 */
	public User queryUserByIU(User user);
	
	/**
	 * 修改用户密码
	 * @author 潘昱东
	 * @param user
	 * @return 
	 */
	public int updateUser(User user);
}
