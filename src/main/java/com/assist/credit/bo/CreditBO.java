package com.assist.credit.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.assist.credit.dao.CreditDAO;
import com.assist.credit.model.Credit;

@Service
public class CreditBO {
	private static final int CREDIT_MAX_SIZE = 5;
	private int prevNum = -CREDIT_MAX_SIZE;
	private int nextNum = CREDIT_MAX_SIZE;
	
	@Autowired
	private CreditDAO creditDAO;
	
	public List<Credit> getCreditList(int userId, Integer prevId, Integer nextId) {
		Integer offsetNum = 0;
		
		if (prevId != null) {
			// 이전 클릭
			prevNum = prevId - CREDIT_MAX_SIZE;
			nextNum = nextNum - CREDIT_MAX_SIZE;
			offsetNum = prevId;		
		} else if (nextId != null) {
			// 다음 클릭
			prevNum = prevNum + CREDIT_MAX_SIZE;
			nextNum = nextId + CREDIT_MAX_SIZE;
			offsetNum = nextId;
		} else {
			// 리셋
			this.prevNum = -CREDIT_MAX_SIZE;
			this.nextNum = CREDIT_MAX_SIZE;
		}
		
		return creditDAO.selectCreditList(userId, offsetNum, CREDIT_MAX_SIZE);
	}
	public int getPrevNum() {
		return prevNum;
	}
	public int getNextNum() {
		return nextNum;
	}
	public int getCreditListSize(int userId) {
		return creditDAO.selectCreditListSize(userId);
	}
	public int getMaxSize() {
		return CREDIT_MAX_SIZE;
	}

}
