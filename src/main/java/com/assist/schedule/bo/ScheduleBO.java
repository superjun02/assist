package com.assist.schedule.bo;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.assist.schedule.dao.ScheduleDAO;
import com.assist.schedule.model.Schedule;

@Service
public class ScheduleBO {
	private static final int SCHEDULE_MAX_SIZE = 5;
	private int prevNum;
	private int nextNum;
	
	@Autowired
	private ScheduleDAO scheduleDAO;
	
	public List<Schedule> getScheduleListByUserId(int userId) {
		
		List<Schedule> scheduleList = scheduleDAO.selectScheduleListByUserId(userId);
		
		Iterator<Schedule> itr = scheduleList.iterator();

		while(itr.hasNext())
		{
			Schedule schedule = itr.next();
			
			String endDate = schedule.getEnd();
			SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
			
			try {
				Date end = fm.parse(endDate);
				
				Calendar cal = Calendar.getInstance();
				cal.setTime(end);
				cal.add(Calendar.DATE, 1);
				end = cal.getTime();
				
				endDate = fm.format(end);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			schedule.setEnd(endDate);
		}
		
		return scheduleList;
	}

	public void addSchedule(int userId, String title, String start, String end) {
		scheduleDAO.insertSchedule(userId, title, start, end);
	}
	
	public List<Schedule> getScheduleList(int userId, Integer prevId, Integer nextId) {
		Integer offsetNum = 0;
		
		if (prevId != null) {
			// 이전 클릭
			prevNum = prevId - SCHEDULE_MAX_SIZE;
			nextNum = prevId + SCHEDULE_MAX_SIZE;
			offsetNum = prevId;		
		} else if (nextId != null) {
			// 다음 클릭
			prevNum = nextId - SCHEDULE_MAX_SIZE;
			nextNum = nextId + SCHEDULE_MAX_SIZE;
			offsetNum = nextId;
		} else {
			// 리셋
			this.prevNum = -SCHEDULE_MAX_SIZE;
			this.nextNum = SCHEDULE_MAX_SIZE;
		}
		
		return scheduleDAO.selectScheduleList(userId, offsetNum, SCHEDULE_MAX_SIZE);
	}
	public int getPrevNum() {
		return prevNum;
	}
	public int getNextNum() {
		return nextNum;
	}
	public int getScheduleListSize(int userId) {
		return scheduleDAO.selectScheduleListSize(userId);
	}
	public int getMaxSize() {
		return SCHEDULE_MAX_SIZE;
	}

	public void deleteSchedule(int scheduleId) {
		scheduleDAO.deleteSchedule(scheduleId);
	}

	public void updateSchedule(int scheduleId, String title, String startDate, String endDate) {
		scheduleDAO.updateSchedule(scheduleId, title, startDate, endDate);
	}

}
