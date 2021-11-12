package com.assist.schedule.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.assist.schedule.model.Schedule;

@Repository
public interface ScheduleDAO {

	public List<Schedule> selectScheduleListByUserId(int userId);

	public void insertSchedule(
			@Param("userId") int userId
			, @Param("title") String title
			, @Param("start") String start
			, @Param("end") String end);
	
	public List<Schedule> selectScheduleList(
			@Param("userId") int userId
			, @Param("offsetNum") Integer offsetNum
			, @Param("limit") int limit
			, @Param("today") String today);

	public int selectScheduleListSize(
			@Param("userId") int userId
			,@Param("today") String today);

	public void deleteSchedule(int scheduleId);

	public void updateSchedule(
			@Param("scheduleId") int scheduleId
			,@Param("title") String title
			,@Param("startDate") String startDate
			,@Param("endDate") String endDate);

	public List<Schedule> selectScheduleListLimitFive(
			@Param("userId") int userId
			,@Param("now") String now);
}
