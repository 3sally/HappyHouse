package com.ssafy.happyhouseproject.model.mapper;

import java.util.List;

import com.ssafy.happyhouseproject.model.UserDto;
import com.ssafy.happyhouseproject.model.UserInterestDto;

public interface UserMapper {

	UserDto login(UserDto userDto) throws Exception;

	UserDto getUserById(String id) throws Exception; // 회원정보 업데이트시 회원정보 불러올 때 사용

	int idCheck(String id) throws Exception; // 아이디 중복 여부 판단

	boolean registUser(UserDto userDto) throws Exception;

	List<UserDto> listUser() throws Exception;

	boolean updateUser(UserDto userDto) throws Exception;

	boolean deleteUser(String id) throws Exception;

	boolean setInterestDong(UserInterestDto userInterestDto) throws Exception;

	String getArea(String userId);

	boolean updateInterestArea(UserDto userDto);
}
