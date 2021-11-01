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

<div id='calendar' class="col-11 pt-2"></div>
<c:forEach var="schedule" items="${scheduleList}">
	${schedule.content}
	${schedule.startDate}
	${schedule.endDate}
</c:forEach>
<script>

document.addEventListener('DOMContentLoaded', function() {
	var arr = [
		
        {
       		title: '숙제',
           	start: '2021-10-05',
           	end: '2021-10-07'
        },
        {
         	title: '학원',
          	start: '2021-10-28',
          	end: '2021-10-29'
        },
      ];
	
    var calendarEl = document.getElementById('calendar');
	
    var calendar = new FullCalendar.Calendar(calendarEl, {
      plugins: [ 'interaction', 'dayGrid' ],
      locale: 'ko',
      
      events: arr
    });

    calendar.render();
  });
</script>
