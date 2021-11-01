package com.assist.schedule.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.assist.schedule.model.Schedule;

@Repository
public interface ScheduleDAO {

	List<Schedule> selectScheduleListByUserId(int userId);

}
