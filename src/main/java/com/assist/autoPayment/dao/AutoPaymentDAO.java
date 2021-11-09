package com.assist.autoPayment.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.assist.autoPayment.model.AutoPayment;

@Repository
public interface AutoPaymentDAO {

	public List<AutoPayment> selectAutoPaymentList(Integer userId);

	public void insertAutoPayment(
			@Param("userId") Integer userId
			,@Param("day") int day
			,@Param("usedPlace") String usedPlace
			,@Param("price") int price);

	public void deleteAutoPayment(int autoPaymentId);

	public void updateAutoPayment(
			@Param("autoPaymentId") int autoPaymentId
			,@Param("day") int day
			,@Param("usedPlace") String usedPlace
			,@Param("price") int price);
	
	public AutoPayment selectAutoPayment(
			@Param("userId") int userId
			,@Param("day") String day);

}
