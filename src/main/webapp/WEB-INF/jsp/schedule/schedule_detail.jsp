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
			<th class="col-4">시작일</th>
			<th class="col-4">종료일</th>
			<th class="col-4">내용</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="schedule" items="${scheduleList}" varStatus="status">
			<tr class="schedule text-center" data-toggle="modal"
				data-target=".${schedule.id}">
				<td>${schedule.start}</td>
				<td>${schedule.end}</td>
				<td>${schedule.title}</td>
			</tr>
			<div class="${schedule.id} modal fade" tabindex="-1" role="dialog"
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
							<input type="text" id="title${status.count}" class="form-control"
								value="${schedule.title}">
							<div
								class="d-flex justify-content-between align-items-center pt-2">
								<span>시작일</span> <input type="text" id="startDate${status.count}"
									class="form-control col-4 startDate" value="${schedule.start}">

								<span>종료일</span> <input type="text" id="endDate${status.count}"
									class="form-control col-4 endDate" value="${schedule.end}">
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="deleteBtn btn btn-secondary"
								data-schedule-id="${schedule.id}">삭제</button>
							<button type="button" class="updateBtn btn btn-primary"
								data-status-id="${status.count}" data-schedule-id="${schedule.id}">수정</button>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</tbody>
</table>
<div class="d-flex justify-content-center">
	<c:if test="${prevId >= 0}">
		<a href="/schedule/schedule_detail_view?prevId=${prevId}" class="mr-3">&lt;&lt;
			이전</a>
	</c:if>
	<c:if test="${nextId >= 0}">
		<a href="/schedule/schedule_detail_view?nextId=${nextId}" class="ml-3">다음
			&gt;&gt;</a>
	</c:if>
</div>
<script>
	$(document).ready(function() {
		$('.startDate').attr('readonly', true);
		$('.endDate').attr('readonly', true);


		$.datepicker
				.setDefaults({
					dayNamesMin : [ '일', '월', '화', '수', '목',
							'금', '토' ],
					monthNames : [ '1월', '2월', '3월', '4월',
							'5월', '6월', '7월', '8월', '9월',
							'10월', '11월', '12월' ],
					dateFormat : 'yy-mm-dd',
					nextText : '다음 달',
					prevText : '이전 달'
				});

		$.datepicker._gotoToday = function(id) {
			$(id).datepicker('setDate', new Date()).datepicker(
					'hide').blur();
		};

		$('.startDate').datepicker(
				{
					onSelect : function(dateText) {
						$('#endDate').datepicker('option',
								'minDate', dateText);
					}
				});

		$('.endDate').datepicker({
			minDate : 0
		});

		$('.deleteBtn').on('click', function() {
			let scheduleId = $(this).data('schedule-id');
			
			if (confirm("삭제 하시겠습니까?")) {
				$.ajax({
					type: 'delete'
					, url: '/schedule/delete'
					, data: {'scheduleId':scheduleId}
					, success: function(data) {
						if (data.result == 'success') {
							alert('삭제 되었습니다');
							location.href = '/schedule/schedule_view';
						}
					}, error: function(e) {
						alert("일정을 삭제하는데 실패했습니다. " + e);
					}
				});
			}
		});
		
		$('.updateBtn').on('click', function() {
			let statusId = $(this).data('status-id');
			let scheduleId = $(this).data('schedule-id');
			
			let title = $('#title' + statusId).val();
			let startDate = $('#startDate' + statusId).val();
			let endDate = $('#endDate' + statusId).val();
			
			if (title == '') {
        		alert("내용을 입력하세요");
        		return;
        	}
        	
        	if (startDate == '') {
        		alert("시작일을 입력하세요");
        		return;
        	}
        	
        	if (endDate == '') {
        		alert("종료일을 입력하세요");
        		return;
        	}
        	
        	var url = '/schedule/update';    
			var data = {'scheduleId':scheduleId, 'title':title, 'startDate':startDate, 'endDate':endDate};
			
			$.post(url, data)
			.done(function(data) {
				if (data.result == "success") {
					alert("수정됬습니다");				
					location.href = '/schedule/schedule_view';
				} else {
					alert("수정에 실패했습니다. 다시 시도해주세요.");
				}
			}); 
		});	
	});
</script>