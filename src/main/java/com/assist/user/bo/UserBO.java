package com.assist.user.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.assist.user.dao.UserDAO;
import com.assist.user.model.User;

@Service
public class UserBO {
	@Autowired
	private UserDAO userDAO;
	
	public User getUser(String loginId, String password) {
		return userDAO.selectUserByLoginIdPassword(loginId, password);
	}
	
	public int existLoginId(String loginId) {
		return userDAO.existLoginId(loginId);
	}

	public int insertUser(String name, String loginId, String encryptPassword) {	
		return userDAO.insertUser(name, loginId, encryptPassword);
	}
}
