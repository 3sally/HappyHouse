package com.ssafy.happyhouseproject.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouseproject.model.UserDto;
import com.ssafy.happyhouseproject.model.mapper.UserMapper;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public UserDto login(UserDto userDto) throws Exception {
		System.out.println("userService : " + userDto);
		if (userDto.getUserId() == null || userDto.getUserPass() == null) {
			System.out.println("userService => getUserId : " + userDto.getUserId());
			System.out.println("userService => getUserPass : " + userDto.getUserPass());
			return null;
		}
		return sqlSession.getMapper(UserMapper.class).login(userDto);
	}

	@Override
	public UserDto getUserById(String id) throws Exception {
		return sqlSession.getMapper(UserMapper.class).getUserById(id);
	}

	@Override
	public int idCheck(String id) throws Exception {
		return sqlSession.getMapper(UserMapper.class).idCheck(id);
	}

	@Override
	public boolean registUser(UserDto userDto) throws Exception {
		sqlSession.getMapper(UserMapper.class).setInterestDong(userDto);
		if (sqlSession.getMapper(UserMapper.class).registUser(userDto))
			return true;
		return false;
	}

	@Override
	public List<UserDto> listUser() throws Exception {
		return sqlSession.getMapper(UserMapper.class).listUser();
	}

	@Override
	public boolean updateUser(UserDto userDto) throws Exception {
		System.out.println(userDto);
		return sqlSession.getMapper(UserMapper.class).updateUser(userDto);
	}

	@Override
	public boolean deleteUser(String id) throws Exception {
		return sqlSession.getMapper(UserMapper.class).deleteUser(id);
	}

	@Override
	public String getArea(String userId) {
		return sqlSession.getMapper(UserMapper.class).getArea(userId);
	}

	@Override
	public boolean updateInterestArea(UserDto userDto) {
		return sqlSession.getMapper(UserMapper.class).updateInterestArea(userDto);
	}

}
