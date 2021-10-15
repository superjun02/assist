package com.assist.user.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.assist.user.model.User;

@Repository
public interface UserDAO {
	public User selectUserByLoginIdPassword(
			@Param("loginId") String loginId, 
			@Param("password") String password);
	
	public int existLoginId(String loginId);

	public int insertUser(
			@Param("name") String name,
			@Param("loginId") String loginId, 
			@Param("password") String password);
}
