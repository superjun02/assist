package com.assist.credit;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.assist.credit.bo.CreditBO;
import com.assist.credit.model.Credit;

@Controller
public class CreditController {
	@Autowired
	private CreditBO creditBO;
	
	@RequestMapping("/credit/credit_view")
	public String credit(Model model,
			HttpServletRequest request,
			@RequestParam(value="prevId", required = false) Integer prevIdParam,
			@RequestParam(value="nextId", required = false) Integer nextIdParam,
			@RequestParam("category") String category) {
		HttpSession session = request.getSession();
		
		String userName = (String) session.getAttribute("userName");
		Integer userId = (Integer) session.getAttribute("userId");
		
		if (userId == null) {
			return "redirect:/user/sign_in_view";
		}
		session.setAttribute("tabName", "credit");
		
		int listSize = creditBO.getCreditListSize(userId, category);
		
		List<Credit> creditList = creditBO.getCreditList(userId, prevIdParam, nextIdParam, category);
		
		int prevId = creditBO.getPrevNum();
		int nextId = creditBO.getNextNum();
		
		if (nextId == (((listSize - 1) / creditBO.getMaxSize()) + 1) * creditBO.getMaxSize()) {
			model.addAttribute("nextId", -1);
		} else {
			model.addAttribute("nextId", nextId);
		}
		
		model.addAttribute("category", category);
		model.addAttribute("prevId", prevId);
		model.addAttribute("creditList", creditList);
		model.addAttribute("userName", userName);
		model.addAttribute("viewName", "credit/credit");
		return "template/contentLayout";
	}
	
	@RequestMapping("credit/credit_detail_view")
	public String creditDetail(Model model,
			HttpServletRequest request,
			@RequestParam("creditId") int creditId) {
		HttpSession session = request.getSession();
		
		String userName = (String) session.getAttribute("userName");
		Integer userId = (Integer) session.getAttribute("userId");
		
		if (userId == null) {
			return "redirect:/user/sign_in_view";
		}
		session.setAttribute("tabName", "credit");
		
		Credit credit = creditBO.getCreditById(creditId, userId);
		
		if (credit == null) {
			return "redirect:/home/home_view";
		}
		
		model.addAttribute("userName", userName);
		model.addAttribute("credit", credit);
		model.addAttribute("viewName", "credit/credit_detail");
		return "template/contentLayout";
	}
	
	@RequestMapping("/credit/credit_create_view")
	public String creditCreate(Model model,
			HttpServletRequest request) {
		HttpSession session = request.getSession();
		
		String userName = (String) session.getAttribute("userName");
		Integer userId = (Integer) session.getAttribute("userId");
		
		if (userId == null) {
			return "redirect:/user/sign_in_view";
		}
		session.setAttribute("tabName", "credit");
		
		model.addAttribute("userName", userName);
		model.addAttribute("viewName", "credit/credit_create");
		return "template/contentLayout";
	}
}
