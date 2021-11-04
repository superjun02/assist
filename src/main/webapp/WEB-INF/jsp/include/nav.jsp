<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="navBox">
	<c:if test="${tabName eq 'home'}">
		<div class="boldMenu d-flex align-items-center" OnClick="location.href ='/home/home_view'">
			<span class="ml-3 mr-3">홈</span>
		</div>
	</c:if>
	<c:if test="${tabName ne 'home'}">
		<div class="menu w-100 d-flex align-items-center" OnClick="location.href ='/home/home_view'">
			<span class="ml-3 mr-3">홈</span>
		</div>
	</c:if>
	<c:if test="${tabName eq 'credit'}">
		<div class="boldMenu w-100 d-flex align-items-center" OnClick="location.href ='/credit/credit_view?category=전체'">
			<span class="ml-3 mr-3">가계부</span>
		</div>
	</c:if>
	<c:if test="${tabName ne 'credit'}">
		<div class="menu w-100 d-flex align-items-center" OnClick="location.href ='/credit/credit_view?category=전체'">
			<span class="ml-3 mr-3">가계부</span>
		</div>
	</c:if>	
	<c:if test="${tabName eq 'pattern'}">
		<div class="boldMenu w-100 d-flex align-items-center" OnClick="location.href ='/pattern/pattern_view'">
			<span class="ml-3 mr-3">소비 패턴</span>
		</div>
	</c:if>
	<c:if test="${tabName ne 'pattern'}">
		<div class="menu w-100 d-flex align-items-center" OnClick="location.href ='/pattern/pattern_view'">
			<span class="ml-3 mr-3">소비 패턴</span>
		</div>
	</c:if>	
	<c:if test="${tabName eq 'schedule'}">
		<div class="boldMenu w-100 d-flex align-items-center" OnClick="location.href ='/schedule/schedule_view'">
			<span class="ml-3 mr-3">캘린더</span>
		</div>
	</c:if>
	<c:if test="${tabName ne 'schedule'}">
		<div class="menu w-100 d-flex align-items-center" OnClick="location.href ='/schedule/schedule_view'">
			<span class="ml-3 mr-3">캘린더</span>
		</div>
	</c:if>	
	<c:if test="${tabName eq 'autoPayment'}">
		<div class="boldMenu w-100 d-flex align-items-center" OnClick="location.href ='/auto_payment/auto_payment_view'">
			<span class="ml-3 mr-3">정기 결제 관리</span>
		</div>
	</c:if>
	<c:if test="${tabName ne 'autoPayment'}">
		<div class="menu w-100 d-flex align-items-center" OnClick="location.href ='/auto_payment/auto_payment_view'">
			<span class="ml-3 mr-3">정기 결제 관리</span>
		</div>
	</c:if>
	<div class="leftBox w-100"></div>	
</div>