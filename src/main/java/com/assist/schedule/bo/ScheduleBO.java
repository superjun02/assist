package com.assist.schedule.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.assist.schedule.dao.ScheduleDAO;
import com.assist.schedule.model.Schedule;

@Service
public class ScheduleBO {
	@Autowired
	private ScheduleDAO scheduleDAO;
	
	public List<Schedule> getScheduleListByUserId(int userId) {
		return scheduleDAO.selectScheduleListByUserId(userId);
	}

}
