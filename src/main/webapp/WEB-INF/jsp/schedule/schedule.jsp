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
<div class="d-flex">
	<div id='calendar' class="col-11 pt-2"></div>
	<div class="pt-2 col-1">
		<div class="w-100">
			<button type="button" class="btn btn-secondary">수정</button>
		</div>	
		<div class="pt-2">
			<button type="button" class="btn btn-primary">추가</button>
		</div>
	</div>
</div>
<script>

document.addEventListener('DOMContentLoaded', function() {
	var arr = ${json}
	
	var calendarEl = document.getElementById('calendar');
	
    var calendar = new FullCalendar.Calendar(calendarEl, {
      plugins: [ 'interaction', 'dayGrid' ],
      locale: 'ko',
      
      events: arr
    });

    calendar.render();
  });
</script>
