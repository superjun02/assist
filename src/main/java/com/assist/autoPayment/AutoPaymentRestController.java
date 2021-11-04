package com.assist.autoPayment;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.assist.autoPayment.bo.AutoPaymentBO;

@RestController
public class AutoPaymentRestController {
	@Autowired
	private AutoPaymentBO autoPaymentBO;
	
	@PostMapping("/auto_payment/create")
	public Map<String, Object> create(HttpServletRequest request,
			@RequestParam("day") int day,
			@RequestParam("usedPlace") String usedPlace,
			@RequestParam("price") int price) { 
		HttpSession session = request.getSession();
		
		Integer userId = (Integer) session.getAttribute("userId");
		
		autoPaymentBO.addAutoPayment(userId, day, usedPlace, price);
		
		Map<String, Object> result = new HashMap<>();
		result.put("result", "success");

		return result;
	}
	
	@DeleteMapping("/auto_payment/delete")
	public Map<String, Object> delete(
			@RequestParam("autoPaymentId") int autoPaymentId) {
		
		autoPaymentBO.deleteAutoPayment(autoPaymentId);
		
		Map<String, Object> result = new HashMap<>();
		result.put("result", "success");

		return result;
	}
	
	@PostMapping("auto_payment/update")
	public Map<String, Object> update(
			@RequestParam("autoPaymentId") int autoPaymentId,
			@RequestParam("day") int day,
			@RequestParam("usedPlace") String usedPlace,
			@RequestParam("price") int price) {
		
		autoPaymentBO.updateAutoPayment(autoPaymentId, day, usedPlace, price);
		
		Map<String, Object> result = new HashMap<>();
		result.put("result", "success");
		
		return result;
	}
}
