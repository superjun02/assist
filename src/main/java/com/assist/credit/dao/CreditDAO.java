package com.assist.credit.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.assist.credit.model.Credit;

@Repository
public interface CreditDAO {
	public List<Credit> selectCreditList(
			@Param("userId") int userId
			, @Param("offsetNum") Integer offsetNum
			, @Param("limit") int limit);
	
	public int selectIdByUserIdAndSort(
			@Param("userId") int userId
			, @Param("sort") String sort);

	public int selectCreditListSize(int userId);
}
