package com.assist.autoPayment;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.assist.autoPayment.bo.AutoPaymentBO;
import com.assist.autoPayment.model.AutoPayment;

@Controller
public class AutoPaymentController {
	@Autowired
	private AutoPaymentBO autoPaymentBO;
	
	@RequestMapping("/auto_payment/auto_payment_view")
	public String autoPayment(Model model,
			HttpServletRequest request) {
		HttpSession session = request.getSession();
		
		String userName = (String) session.getAttribute("userName");
		Integer userId = (Integer) session.getAttribute("userId");
		
		if (userId == null) {
			return "redirect:/user/sign_in_view";
		}
		session.setAttribute("tabName", "autoPayment");
		
		List<AutoPayment> autoPaymentList = autoPaymentBO.getAutoPaymentList(userId);

		model.addAttribute("autoPaymentList", autoPaymentList);
		model.addAttribute("userName", userName);
		model.addAttribute("viewName", "auto_payment/auto_payment");
		return "template/contentLayout";
	}
}
