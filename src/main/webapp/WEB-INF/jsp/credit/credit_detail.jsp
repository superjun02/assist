<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="d-flex w-100 pt-2">
	<div class="col-2">
		<span>카테고리</span>
		<div class="pt-1">
			<input type="text" class="form-control" id="category" value="${credit.category}">
		</div>
	</div>
	<div class="col-3">
		<span>설명</span>
		<div class="pt-1">
			<input type="text" class="form-control" id="description" value="${credit.description}">
		</div>
	</div>
	<div class="col-2">
		<span>금액</span>
		<div class="pt-1">
			<input type="text" class="form-control" id="amount" value="${credit.amount}">
		</div>
	</div>
	<div class="col-3">
		<span>날짜</span>
		<div class="pt-1">
			<fmt:formatDate var="date" value="${credit.date}" pattern="yyyy-MM-dd" />
			<input type="date" class="form-control" id="date" value="${date}">
		</div>
	</div>
	<div class="col-2">
		<span>지출/수입</span>
		<div class="pt-1">
			<select id="type" class="form-control">
				<c:if test="${credit.type eq '지출'}">
					<option value="지출">지출</option>
					<option value="수입">수입</option>
				</c:if>
				<c:if test="${credit.type eq '수입'}">
					<option value="수입">수입</option>
					<option value="지출">지출</option>
				</c:if>
			</select>
		</div>
	</div>
</div>
<div class="d-flex justify-content-end pr-3 pt-3">
	<div>
		<button type="button" id="delete" class="btn btn-secondary" data-credit-id="${credit.id}">삭제</button>
		<button type="button" id="update" class="btn btn-primary" data-credit-id="${credit.id}">수정</button>
	</div>
</div>

<script>
	$(document).ready(function() {
		$('#update').on('click', function() {
			let category = $('#category').val().trim();
			let description = $('#description').val().trim();
			let amount = $('#amount').val().trim();
			let date = $('#date').val().trim();
			let type = $('#type').val().trim();
			
			
			if (category == '') {
				alert("카테고리를 입력하세요.");
				return;
			}
			
			if (description == '') {
				alert("설명을 입력하세요.");
				return;
			}
			
			if (amount == '') {
				alert("금액을 입력하세요.");
				return;
			}
			
			if (date == '') {
				alert("날짜를 입력하세요.");
				return;
			}
			
			let creditId = $(this).data('credit-id');
			var url = '/credit/update';    
			var data = {'creditId':creditId, 'category':category, 'description':description, 'amount':amount, 'date':date, 'type':type};
			
			$.post(url, data)
			.done(function(data) {
				if (data.result == "success") {
					alert("수정됬습니다");				
					location.href = '/credit/credit_view';
				} else {
					alert("수정에 실패했습니다. 다시 시도해주세요.");
				}
			}); 
		});
		
		$('#delete').on('click', function() {
			let creditId = $(this).data('credit-id');

			if (confirm("삭제 하시겠습니까?")) {
				$.ajax({
					type: 'delete'
					, url: '/credit/delete'
					, data: {'creditId':creditId}
					, success: function(data) {
						if (data.result == 'success') {
							alert('삭제 되었습니다');
							location.href = '/credit/credit_view';
						}
					}, error: function(e) {
						alert("가계부를 삭제하는데 실패했습니다. " + e);
					}
				});
			}
		});
	});
</script>