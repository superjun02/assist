<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="d-flex w-100 pt-2">
	<div class="col-2">
		<span>카테고리</span>
		<div class="pt-1">
			<select id="category" class="form-control">
				<option value="기타">기타</option>
				<option value="요식">요식</option>
				<option value="쇼핑">쇼핑</option>
				<option value="교육">교육</option>
				<option value="생활">생활</option>
				<option value="레저">레저</option>
				<option value="문화">문화</option>
				<option value="월급">월급</option>
			</select>
		</div>
	</div>
	<div class="col-3">
		<span>설명</span>
		<div class="pt-1">
			<input type="text" class="form-control" id="description">
		</div>
	</div>
	<div class="col-2">
		<span>금액</span>
		<div class="pt-1">
			<input type="text" class="form-control" id="amount">
		</div>
	</div>
	<div class="col-3">
		<span>날짜</span>
		<div class="pt-1">
			<input type="date" class="form-control" id="date">
		</div>
	</div>
	<div class="col-2">
		<span>지출/수입</span>
		<div class="pt-1">
			<select id="type" class="form-control">
				<option value="지출">지출</option>
				<option value="수입">수입</option>
			</select>
		</div>
	</div>
</div>
<div class="d-flex justify-content-end pr-3 pt-3">
	<div>
		<button type="button" id="create" class="btn btn-primary">추가</button>
	</div>
</div>

<script>
	$(document).ready(function() {
		$('#create').on('click', function() {
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
			
			var url = '/credit/create';    
			var data = {'category':category, 'description':description, 'amount':amount, 'date':date, 'type':type};
			
			$.post(url, data)
			.done(function(data) {
				if (data.result == "success") {
					alert("추가됬습니다");				
					location.href = '/credit/credit_view?category=전체';
				} else {
					alert("추가에 실패했습니다. 다시 시도해주세요.");
				}
			}); 
		});
	});
</script>