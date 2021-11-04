package com.assist.pattern.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.assist.credit.dao.CreditDAO;
import com.assist.pattern.model.Pattern;

@Service
public class PatternBO {
	@Autowired
	private CreditDAO creditDAO;
	
	public Pattern getMonthPattern(Integer userId, String month) {
		Pattern pattern = new Pattern();
		
		pattern.setEtc(creditDAO.selectMonthPattern(userId, "기타", month));
		pattern.setCulture(creditDAO.selectMonthPattern(userId, "문화", month));
		pattern.setEducate(creditDAO.selectMonthPattern(userId, "교육", month));
		pattern.setFood(creditDAO.selectMonthPattern(userId, "요식", month));
		pattern.setLeisure(creditDAO.selectMonthPattern(userId, "레저", month));
		pattern.setLife(creditDAO.selectMonthPattern(userId, "생활", month));
		pattern.setShopping(creditDAO.selectMonthPattern(userId, "쇼핑", month));
		
		return pattern;
	}

}
