<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<input type="text" id="defaultData" class="d-none" value="${category}">
<div class="pt-1 pb-1">
	<select id="category" class="form-control">
		<option id="전체" value="전체">전체</option>
		<option id="기타" value="기타">기타</option>
		<option id="요식" value="요식">요식</option>
		<option id="쇼핑" value="쇼핑">쇼핑</option>
		<option id="교육" value="교육">교육</option>
		<option id="생활" value="생활">생활</option>
		<option id="레저" value="레저">레저</option>
		<option id="문화" value="문화">문화</option>
		<option id="월급" value="월급">월급</option>
	</select>
</div>
<table class="table table-hover">
	<thead>
		<tr class="text-center">
			<th>카테고리</th>
			<th>설명</th>
			<th>금액</th>
			<th>날짜</th>
			<th>지출/수입</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="credit" items="${creditList}">
			<tr class="credit text-center" onClick = " location.href='/credit/credit_detail_view?creditId=${credit.id}' ">
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
		<a href="/credit/credit_view?category=${category}&prevId=${prevId}" class="mr-3">&lt;&lt; 이전</a>
	</c:if>
	<c:if test="${nextId >= 0}">
		<a href="/credit/credit_view?category=${category}&nextId=${nextId}" class="ml-3">다음 &gt;&gt;</a>
	</c:if>
</div>
	
<div class="d-flex justify-content-end">
	<a href="/credit/credit_create_view" class="btn btn-primary">내역추가</a>
</div>
<script>
	$(document).ready(function() {
		let defaultId = $('#defaultData').val();
		
		$('#' + defaultId).attr("selected", "selected");
		
		$('#category').on('change', function() {
			let category = $('#category').val();
			location.href = '/credit/credit_view?category=' + category;			
		});
	});
</script>