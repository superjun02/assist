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

	public int selectCreditListSize(int userId);

	public Credit selectCreditById(
			@Param("creditId") int creditId,
			@Param("userId") int userId);

	public void deleteCredit(int creditId);

	public void updateCredit(
			@Param("id") int creditId
			, @Param("category") String category
			, @Param("description") String description
			, @Param("amount") int amount
			, @Param("date") String date
			, @Param("type") String type);

	public void insertCredit(
			@Param("userId") int userId
			, @Param("category") String category
			, @Param("description") String description
			, @Param("amount") int amount
			, @Param("date") String date
			, @Param("type") String type);
	
	public Integer selectMonthPattern(
			@Param("userId") int userId
			,@Param("category") String category
			,@Param("date") String month);

	public List<Credit> selectCreditListAndCategory(
			@Param("userId") int userId
			, @Param("offsetNum") Integer offsetNum
			, @Param("category") String category
			, @Param("limit") int limit);

	public int selectCreditListSizeAndCategory(
			@Param("userId") int userId
			,@Param("category") String category);

	public Integer selectSumOfCreditByType(
			@Param("userId") int userId
			,@Param("type") String type);
}
