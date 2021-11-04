<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<table class="table table-hover">
	<thead>
		<tr class="text-center">
			<th class="col-4">날짜</th>
			<th class="col-4">사용처</th>
			<th class="col-4">금액</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="autoPayment" items="${autoPaymentList}" varStatus="status">
			<tr class="schedule text-center" data-toggle="modal"
				data-target=".${autoPayment.id}">
				<td>${autoPayment.day}</td>
				<td>${autoPayment.usedPlace}</td>
				<td>
					<fmt:formatNumber value="${autoPayment.price}" type="currency" /><br>
				</td>
			</tr>
			<div class="${autoPayment.id} modal fade" tabindex="-1" role="dialog"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">수정/삭제</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<div class="d-flex justify-content-between align-items-center">
								<span>날짜</span>
								<input type="text" class="form-control col-4" id="day${status.count}"
								value="${autoPayment.day}">
								
								<span>금액</span>
								<input type="text" class="form-control col-4" id="price${status.count}"
								value="${autoPayment.price}">
				       		</div>
				       		<div class="pt-2">
				       			<input type="text" id="usedPlace${status.count}" class="form-control" id="usedPlace${status.count}" 
				       			value="${autoPayment.usedPlace}" placeholder="사용처">
				       		</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="deleteBtn btn btn-secondary"
								data-auto-id="${autoPayment.id}">삭제</button>
							<button type="button" class="updateBtn btn btn-primary"
								data-status-id="${status.count}" data-auto-id="${autoPayment.id}">수정</button>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</tbody>
</table>
<div class="d-flex w-100 pt-2 justify-content-end">
	<div class="col-2">
		<span>날짜</span>
		<div class="pt-1">
			<input type="text" class="form-control" id="day">
		</div>
	</div>
	<div class="col-4">
		<span>사용처</span>
		<div class="pt-1">
			<input type="text" class="form-control" id="usedPlace">
		</div>
	</div>
	<div class="col-2">
		<span>금액</span>
		<div class="pt-1">
			<input type="text" class="form-control" id="price">
		</div>
	</div>
	<div>
		<span>ㅤ</span>
		<div class="pt-1">
			<button type="button" id="addBtn" class="btn btn-primary">추가</button>
		</div>
	</div>
</div>
<script>
	$(document).ready(function() {
		$('#addBtn').on('click', function() {
        	let day = $('#day').val().trim();
        	let usedPlace = $('#usedPlace').val();
        	let price = $('#price').val();
        	
        	if (day == '') {
        		alert("날짜를 입력하세요");
        		return;
        	}
        	
        	if (usedPlace == '') {
        		alert("사용처를 입력하세요");
        		return;
        	}
        	
        	if (price == '') {
        		alert("금액을 입력하세요");
        		return;
        	}
        	
        	var url = '/auto_payment/create';    
			var data = {'day':day, 'usedPlace':usedPlace, 'price':price};
			
			$.post(url, data)
			.done(function(data) {
				if (data.result == "success") {
					alert("추가됬습니다");				
					location.href = '/auto_payment/auto_payment_view';
				} else {
					alert("추가에 실패했습니다. 다시 시도해주세요.");
				}
			}); 
        });
		
		$('.deleteBtn').on('click', function() {
			let autoPaymentId = $(this).data('auto-id');
			
			if (confirm("삭제 하시겠습니까?")) {
				$.ajax({
					type: 'delete'
					, url: '/auto_payment/delete'
					, data: {'autoPaymentId':autoPaymentId}
					, success: function(data) {
						if (data.result == 'success') {
							alert('삭제 되었습니다');
							location.href = '/auto_payment/auto_payment_view';
						}
					}, error: function(e) {
						alert("일정을 삭제하는데 실패했습니다. " + e);
					}
				});
			}
		});
		
		$('.updateBtn').on('click', function() {
			let statusId = $(this).data('status-id');
			let autoPaymentId = $(this).data('auto-id');
			
			let day = $('#day' + statusId).val();
			let usedPlace = $('#usedPlace' + statusId).val();
			let price = $('#price' + statusId).val();
			
			if (day == '') {
        		alert("날짜를 입력하세요");
        		return;
        	}
        	
        	if (usedPlace == '') {
        		alert("사용처를 입력하세요");
        		return;
        	}
        	
        	if (price == '') {
        		alert("금액을 입력하세요");
        		return;
        	}
        	
        	var url = '/auto_payment/update';    
			var data = {'autoPaymentId':autoPaymentId, 'day':day, 'usedPlace':usedPlace, 'price':price};
			
			$.post(url, data)
			.done(function(data) {
				if (data.result == "success") {
					alert("수정됬습니다");				
					location.href = '/auto_payment/auto_payment_view';
				} else {
					alert("수정에 실패했습니다. 다시 시도해주세요.");
				}
			}); 
		});	
	});
</script>