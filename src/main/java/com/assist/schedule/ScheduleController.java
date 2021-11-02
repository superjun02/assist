package com.assist.schedule;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
	
	@RequestMapping("/schedule/schedule_detail_view")
	public String detail(Model model,
			HttpServletRequest request,
			@RequestParam(value="prevId", required = false) Integer prevIdParam,
			@RequestParam(value="nextId", required = false) Integer nextIdParam) {
		HttpSession session = request.getSession();
		
		String userName = (String) session.getAttribute("userName");
		Integer userId = (Integer) session.getAttribute("userId");
		
		
		int listSize = scheduleBO.getScheduleListSize(userId);
		
		List<Schedule> scheduleList = scheduleBO.getScheduleList(userId, prevIdParam, nextIdParam);
		
		int prevId = scheduleBO.getPrevNum();
		int nextId = scheduleBO.getNextNum();
		
		if (nextId == (((listSize - 1) / scheduleBO.getMaxSize()) + 1) * scheduleBO.getMaxSize()) {
			model.addAttribute("nextId", -1);
		} else {
			model.addAttribute("nextId", nextId);
		}

		model.addAttribute("prevId", prevId);
		model.addAttribute("scheduleList", scheduleList);
		model.addAttribute("userName", userName);
		model.addAttribute("viewName", "schedule/schedule_detail");
		return "template/contentLayout";
	}
}
