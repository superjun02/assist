package com.assist.credit;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.assist.credit.bo.CreditBO;

@RestController
public class CreditRestController {
	@Autowired
	private CreditBO creditBO;
	
	@PostMapping("credit/update")
	public Map<String, Object> update(
			@RequestParam("creditId") int creditId,
			@RequestParam("category") String category,
			@RequestParam("description") String description,
			@RequestParam("amount") int amount,
			@RequestParam("date") String date,
			@RequestParam("type") String type) {
		
		creditBO.updateCredit(creditId, category, description, amount, date, type);
		
		Map<String, Object> result = new HashMap<>();
		result.put("result", "success");
		
		
		return result;
	}
	
	@DeleteMapping("/credit/delete")
	public Map<String, Object> delete(
			@RequestParam("creditId") int creditId) {
		
		creditBO.deleteCredit(creditId);
		
		Map<String, Object> result = new HashMap<>();
		result.put("result", "success");

		return result;
	}
	
	@PostMapping("/credit/create")
	public Map<String, Object> create(HttpServletRequest request,
			@RequestParam("category") String category,
			@RequestParam("description") String description,
			@RequestParam("amount") int amount,
			@RequestParam("date") String date,
			@RequestParam("type") String type) {
		HttpSession session = request.getSession();
		
		Integer userId = (Integer) session.getAttribute("userId");
		
		creditBO.createCredit(userId, category, description, amount, date, type);
		Map<String, Object> result = new HashMap<>();
		result.put("result", "success");

		return result;
	}
}
