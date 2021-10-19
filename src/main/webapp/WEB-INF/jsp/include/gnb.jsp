<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="header d-flex justify-content-between">
	<div class="logo d-flex align-items-center justify-content-center col-2">
		<h1 class="text-white"><a href="/contents/home_view">Assist</a></h1>
	</div>
	<div class="login-info d-flex align-items-center mr-5">
		<c:if test="${not empty userName}">
			<span>${userName}님 안녕하세요</span>
			<a href="/user/sign_out" class="ml-2 font-weight-bold">로그아웃</a>
		</c:if>
		<c:if test="${empty userName}">
			<a href="/user/sign_in_view" class="ml-2 font-weight-bold">로그인</a>
		</c:if>
	</div>
</div>