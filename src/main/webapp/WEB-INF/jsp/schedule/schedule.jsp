<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link rel="stylesheet" href="/static/packages/core/main.css">
<link rel="stylesheet" href="/static/packages/daygrid/main.css">
<script src="/static/packages/core/main.js"></script>
<script src="/static/packages/interaction/main.js"></script>
<script src="/static/packages/daygrid/main.js"></script>
<script src="/static/packages/core/locales/ko.js"></script>

<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<div class="d-flex">
	<div id='calendar' class="col-11 pt-2"></div>
	<div class="pt-2 col-1">
		<div class="w-100">
			<a href="/schedule/schedule_detail_view" class="btn btn-secondary">수정</a>
		</div>
		<div class="pt-2">
			<!-- Button trigger modal -->
			<button type="button"
				class="btn btn-primary font-weight-bold" data-toggle="modal"
				data-target="#exampleModal">추가</button>

			<!-- Modal -->
			<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">일정 추가</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<input type="text" id="title" class="form-control" placeholder="내용">
								<div class="d-flex justify-content-between align-items-center pt-2">
									<span>시작일</span>
									<input type="text" class="form-control col-4" id="startDate">
									
									<span>종료일</span>
									<input type="text" class="form-control col-4" id="endDate">
					       		</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">닫기</button>
							<button type="button" id="addBtn" class="btn btn-primary">추가</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	document.addEventListener('DOMContentLoaded', function() {
		$('#startDate').attr('readonly', true);
		$('#endDate').attr('readonly', true);
		
		var arr = ${json}

		var calendarEl = document.getElementById('calendar');

		var calendar = new FullCalendar.Calendar(calendarEl, {
			plugins : [ 'interaction', 'dayGrid'],
			locale : 'ko',
			eventLimit: true, 
			events : arr
		});

		calendar.render();
		
		$.datepicker.setDefaults({
            dayNamesMin: ['일', '월', '화', '수', '목', '금', '토']
            , monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
            , dateFormat: 'yy-mm-dd'
            , nextText: '다음 달'
            , prevText: '이전 달'
        });

        $.datepicker._gotoToday = function(id) {
            $(id).datepicker('setDate', new Date()).datepicker('hide').blur();
        };


        $('#startDate').datepicker({
            onSelect:function(dateText) {
                $('#endDate').datepicker('option', 'minDate', dateText);
            }
        });

        $('#endDate').datepicker({
            minDate:0 
        });
        
        $('#addBtn').on('click', function() {
        	let title = $('#title').val().trim();
        	let startDate = $('#startDate').val();
        	let endDate = $('#endDate').val();
        	
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
        	
        	var url = '/schedule/create';    
			var data = {'title':title, 'startDate':startDate, 'endDate':endDate};
			
			$.post(url, data)
			.done(function(data) {
				if (data.result == "success") {
					alert("추가됬습니다");				
					location.href = '/schedule/schedule_view';
				} else {
					alert("추가에 실패했습니다. 다시 시도해주세요.");
				}
			}); 
        });
	});
</script>
