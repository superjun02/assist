package com.assist.schedule;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.assist.schedule.bo.ScheduleBO;
import com.assist.schedule.model.Schedule;

import com.google.gson.Gson;
@Controller
public class ScheduleController {
	@Autowired
	private ScheduleBO scheduleBO;
	
	@RequestMapping("/schedule/schedule_view")
	public String credit(Model model,
			HttpServletRequest request) {
		HttpSession session = request.getSession();
		
		String userName = (String) session.getAttribute("userName");
		Integer userId = (Integer) session.getAttribute("userId");
		
		if (userId == null) {
			return "redirect:/user/sign_in_view";
		}
		session.setAttribute("tabName", "schedule");
		
		List<Schedule> scheduleList = new ArrayList<>();
		
		scheduleList = scheduleBO.getScheduleListByUserId(userId);
		
		Gson gson = new Gson();
		String json = gson.toJson(scheduleList);
		
		
		model.addAttribute("json", json);
		model.addAttribute("userName", userName);
		model.addAttribute("viewName", "schedule/schedule");
		return "template/contentLayout";
	}
}
