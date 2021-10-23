package com.assist.home;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class HomeController {
	
	@RequestMapping("/home/home_view")
	public String home(Model model,
			HttpServletRequest request) {
		HttpSession session = request.getSession();
		
		String userName = (String) session.getAttribute("userName");
		Integer userId = (Integer) session.getAttribute("userId");
		
		if (userId == null) {
			return "redirect:/user/sign_in_view";
		}
		
		session.setAttribute("tabName", "home");
		
		model.addAttribute("userName", userName);
		model.addAttribute("viewName", "home/home");
		return "template/contentLayout";
	}
	
}
