<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table class="table table-hover">
		<thead>
			<tr>
				<th>카테고리</th>
				<th>설명</th>
				<th>금액</th>
				<th>날짜</th>
				<th>지출/수입</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="credit" items="${creditList}">
				<tr>
					<td>${credit.category}</td>
					<td>${credit.description}</td>
					<td>
						<fmt:formatNumber value="${credit.amount}" type="currency" /><br>
					</td>
					<td>
						<fmt:formatDate value="${credit.date}" pattern="yyyy-MM-dd" />
					</td>
					<td>${credit.type}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="d-flex justify-content-center">
		<c:if test="${prevId >= 0}">
			<a href="/credit/credit_view?prevId=${prevId}" class="mr-3">&lt;&lt; 이전</a>
		</c:if>
		<c:if test="${nextId >= 0}">
			<a href="/credit/credit_view?nextId=${nextId}" class="ml-3">다음 &gt;&gt;</a>
		</c:if>
	</div>
		
	<div class="d-flex justify-content-end">
		<a href="/credit/credit_create_view" class="btn btn-primary">내역추가</a>
	</div>
</body>
</html>