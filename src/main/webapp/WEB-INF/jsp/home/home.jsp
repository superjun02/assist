<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
<script type="text/javascript">
	google.charts.load('current', {
		'packages' : [ 'corechart' ]
	});
	google.charts.setOnLoadCallback(drawChart);
	function drawChart() {
		var data = new google.visualization.DataTable();
		data.addColumn('string', 'Foods');
		data.addColumn('number', '비중');

		data.addRows([  [ '기타', ${thisMonth.etc} ], [ '문화', ${thisMonth.culture} ], [ '쇼핑', ${thisMonth.shopping} ],
			 			[ '레저', ${thisMonth.leisure} ], [ '요식', ${thisMonth.food} ], [ '생활', ${thisMonth.life} ],
			 			[ '교육', ${thisMonth.educate} ]  ]);
		var opt = {
			'title' : '이번달 지출',
			'width' : 500,
			'height' : 500,
			pieSliceText : 'label',
			legend : 'none', 
			titleTextStyle: {
		        fontSize: 24,
		    }
		};
		var chart = new google.visualization.PieChart(document
				.getElementById('myChart'));
		var formatter = new google.visualization.NumberFormat({pattern: '₩###,###'});
		
        formatter.format(data, 1);
		chart.draw(data, opt);
	}
</script>
<div class="d-flex">
	<div class="col-7">
		<div id="myChart"></div>
	</div>
	
	<div class="col-5">
		<div class="w-100 h-50">
			<div class="p-2">
				<hr>
				<span class="homeText">다가오는 일정</span>
				<div>
					<c:forEach var="schedule" items="${nextThreeSchedule}">
						<div class="pt-1">
							<span class="scheduleText">${schedule.start}</span>
							<span class="scheduleTextTitle">${schedule.title}</span></div> 
					</c:forEach>
				</div>
			</div>
		</div>
		<div class="w-100 h-25">
			<div class="p-2">
				<hr>
				<span class="homeText">다가오는 정기 결제</span>
				<div class="pt-1">
					<c:if test="${not empty nextAutoPayment}">
						<span class="autoPaymentText">
							${nextAutoPayment.day}일
							${nextAutoPayment.usedPlace}
							<fmt:formatNumber value="${nextAutoPayment.price}" type="currency" />
						</span>
					</c:if>
				</div>
			</div>
		</div>
		<div class="w-100 h-25">
			<div class="p-2">
				<hr>
				<span class="homeText">잔액</span>
				<div class="pt-1">
					<span class="balanceText">
						<fmt:formatNumber value="${balance}" type="currency" />
					</span>
				</div>
			</div>
		</div>
	</div>
</div>
