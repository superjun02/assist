package com.assist.schedule;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.assist.schedule.bo.ScheduleBO;

@RestController
public class ScheduleRestController {
	@Autowired
	private ScheduleBO scheduleBO;
	
	@PostMapping("/schedule/create")
	public Map<String, Object> create(HttpServletRequest request,
			@RequestParam("title") String title,
			@RequestParam("startDate") String start,
			@RequestParam("endDate") String end) { 
		HttpSession session = request.getSession();
		
		Integer userId = (Integer) session.getAttribute("userId");
		
		scheduleBO.addSchedule(userId, title, start, end);
		
		Map<String, Object> result = new HashMap<>();
		result.put("result", "success");

		return result;
	}
	
	@DeleteMapping("/schedule/delete")
	public Map<String, Object> delete(
			@RequestParam("scheduleId") int scheduleId) {
		
		scheduleBO.deleteSchedule(scheduleId);
		
		Map<String, Object> result = new HashMap<>();
		result.put("result", "success");

		return result;
	}
	
	@PostMapping("schedule/update")
	public Map<String, Object> update(
			@RequestParam("scheduleId") int scheduleId,
			@RequestParam("title") String title,
			@RequestParam("startDate") String startDate,
			@RequestParam("endDate") String endDate) {
		
		scheduleBO.updateSchedule(scheduleId, title, startDate, endDate);
		
		Map<String, Object> result = new HashMap<>();
		result.put("result", "success");
		
		
		return result;
	}
}
