package com.assist.pattern;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.assist.pattern.bo.PatternBO;
import com.assist.pattern.model.Pattern;

@Controller
public class PatternController {
	@Autowired
	private PatternBO patternBO;
	
	@RequestMapping("/pattern/pattern_view")
	public String pattern(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();

		String userName = (String) session.getAttribute("userName");
		Integer userId = (Integer) session.getAttribute("userId");

		if (userId == null) {
			return "redirect:/user/sign_in_view";
		}
		session.setAttribute("tabName", "pattern");
		
		Calendar cal = Calendar.getInstance();
		
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM");
		String formatedNow = formatter.format(now);

		cal.setTime(now);
		
		cal.add(Calendar.MONTH, -1);
		
		Date prev = cal.getTime();
		String formatedPrev = formatter.format(prev);

		Pattern thisMonthPattern = patternBO.getMonthPattern(userId, formatedNow);
		Pattern prevMonthPattern = patternBO.getMonthPattern(userId, formatedPrev);
				
		model.addAttribute("thisMonth", thisMonthPattern);
		model.addAttribute("prevMonth", prevMonthPattern);
		model.addAttribute("userName", userName);
		model.addAttribute("viewName", "pattern/pattern");
		return "template/contentLayout";
	}
}
