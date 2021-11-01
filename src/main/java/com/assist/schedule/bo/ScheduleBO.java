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

}
