package com.assist.credit.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.assist.credit.dao.CreditDAO;
import com.assist.credit.model.Credit;

@Service
public class CreditBO {
	private static final int CREDIT_MAX_SIZE = 5;
	private int prevNum;
	private int nextNum;
	
	@Autowired
	private CreditDAO creditDAO;
	
	public List<Credit> getCreditList(int userId, Integer prevId, Integer nextId, String category) {
		Integer offsetNum = 0;
		
		if (prevId != null) {
			// 이전 클릭
			prevNum = prevId - CREDIT_MAX_SIZE;
			nextNum = prevId + CREDIT_MAX_SIZE;
			offsetNum = prevId;		
		} else if (nextId != null) {
			// 다음 클릭
			prevNum = nextId - CREDIT_MAX_SIZE;
			nextNum = nextId + CREDIT_MAX_SIZE;
			offsetNum = nextId;
		} else {
			// 리셋
			this.prevNum = -CREDIT_MAX_SIZE;
			this.nextNum = CREDIT_MAX_SIZE;
		}
		
		if (category.equals("전체")) {
			return creditDAO.selectCreditList(userId, offsetNum, CREDIT_MAX_SIZE);
		}
		return creditDAO.selectCreditListAndCategory(userId, offsetNum, category, CREDIT_MAX_SIZE);
	}
	public int getPrevNum() {
		return prevNum;
	}
	public int getNextNum() {
		return nextNum;
	}
	public int getCreditListSize(int userId, String category) {
		if (category.equals("전체")) {
			return creditDAO.selectCreditListSize(userId);
		}
		return creditDAO.selectCreditListSizeAndCategory(userId, category);	
	}
	public int getMaxSize() {
		return CREDIT_MAX_SIZE;
	}
	public Credit getCreditById(int creditId, int userId) {
		return creditDAO.selectCreditById(creditId, userId);
	}
	public void deleteCredit(int creditId) {
		creditDAO.deleteCredit(creditId);
	}
	public void updateCredit(int creditId, String category, String description, int amount, String date, String type) {
		creditDAO.updateCredit(creditId, category, description, amount, date, type);
	}
	public void createCredit(Integer userId, String category, String description, int amount, String date, String type) {
		creditDAO.insertCredit(userId, category, description, amount, date, type);
	}
	
	public Integer getBalance(Integer userId) {
		String type = "수입";
		Integer income = creditDAO.selectSumOfCreditByType(userId, type);
		
		if (income == null) {
			income = 0;
		}
		
		type = "지출";
		Integer expend = creditDAO.selectSumOfCreditByType(userId, type);
		
		if (expend == null) {
			expend = 0;
		}
		
		int balance = income - expend;
		
		return balance;
	}
}
