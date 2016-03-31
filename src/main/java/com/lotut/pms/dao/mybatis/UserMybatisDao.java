package com.lotut.pms.dao.mybatis;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.lotut.pms.dao.UserDao;
import com.lotut.pms.dao.mapper.UserMapper;
import com.lotut.pms.domain.User;

public class UserMybatisDao extends SqlSessionDaoSupport implements UserDao {
	private UserMapper userMapper;
	
	@Override
	public List<User> getAllUsers() {
		return userMapper.getAllUsers();
	}

	public UserMapper getUserMapper() {
		return userMapper;
	}

	public void setUserMapper(UserMapper userMapper) {
		this.userMapper = userMapper;
	}
	
}
