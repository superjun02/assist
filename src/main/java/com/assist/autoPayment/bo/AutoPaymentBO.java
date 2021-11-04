package com.assist.autoPayment.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.assist.autoPayment.dao.AutoPaymentDAO;
import com.assist.autoPayment.model.AutoPayment;

@Service
public class AutoPaymentBO {
	@Autowired
	private AutoPaymentDAO autoPaymentDAO;
	
	public List<AutoPayment> getAutoPaymentList(Integer userId) {
		return autoPaymentDAO.selectAutoPaymentList(userId);
	}

	public void addAutoPayment(Integer userId, int day, String usedPlace, int price) {
		autoPaymentDAO.insertAutoPayment(userId, day, usedPlace, price);
	}

	public void deleteAutoPayment(int autoPaymentId) {
		autoPaymentDAO.deleteAutoPayment(autoPaymentId);
	}

	public void updateAutoPayment(int autoPaymentId, int day, String usedPlace, int price) {
		autoPaymentDAO.updateAutoPayment(autoPaymentId, day, usedPlace, price);
	}

}
