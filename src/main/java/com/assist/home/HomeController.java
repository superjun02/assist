package com.assist.home;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.assist.autoPayment.bo.AutoPaymentBO;
import com.assist.autoPayment.model.AutoPayment;
import com.assist.credit.bo.CreditBO;
import com.assist.pattern.bo.PatternBO;
import com.assist.pattern.model.Pattern;
import com.assist.schedule.bo.ScheduleBO;
import com.assist.schedule.model.Schedule;


@Controller
public class HomeController {
	@Autowired
	private PatternBO patternBO;
	
	@Autowired
	private ScheduleBO scheduleBO;
	
	@Autowired
	private AutoPaymentBO autoPaymentBO;
	
	@Autowired
	private CreditBO creditBO;
	
	@RequestMapping("/home/home_view")
	public String home(Model model,
			HttpServletRequest request) {
		HttpSession session = request.getSession();
		
		String userName = (String) session.getAttribute("userName");
		Integer userId = (Integer) session.getAttribute("userId");
		
		if (userId == null) {
			return "redirect:/user/sign_in_view";
		}
		
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM");
		String formatedNow = formatter.format(now);
		
		SimpleDateFormat formatterMore = new SimpleDateFormat("yyyy-MM-dd hh-mm-ss");
		String formatedNowMore = formatterMore.format(now);
		
		SimpleDateFormat dayForm = new SimpleDateFormat("dd");
		String day = dayForm.format(now);
		
		Pattern thisMonthPattern = patternBO.getMonthPattern(userId, formatedNow);
		List<Schedule> nextThreeSchedule = scheduleBO.getScheduleListLimitFive(userId, formatedNowMore);
		AutoPayment nextAutoPayment = autoPaymentBO.getAutoPayment(userId, day);
		Integer balance = creditBO.getBalance(userId);
		
		session.setAttribute("tabName", "home");
		
		model.addAttribute("thisMonth", thisMonthPattern);
		model.addAttribute("nextThreeSchedule", nextThreeSchedule);
		model.addAttribute("nextAutoPayment", nextAutoPayment);
		model.addAttribute("balance", balance);
		model.addAttribute("userName", userName);
		model.addAttribute("viewName", "home/home");
		return "template/contentLayout";
	}
	
}
