<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
     	google.charts.load('current', {'packages':['bar']});
     	google.charts.setOnLoadCallback(drawChart);

      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['지출', '저번달', '이번달'],
          ['기타', ${prevMonth.etc}, ${thisMonth.etc}],
          ['문화', ${prevMonth.culture}, ${thisMonth.culture}],
          ['쇼핑', ${prevMonth.shopping}, ${thisMonth.shopping}],
          ['레저', ${prevMonth.leisure}, ${thisMonth.leisure}],
          ['요식', ${prevMonth.food}, ${thisMonth.food}],
          ['생활', ${prevMonth.life}, ${thisMonth.life}],
          ['교육', ${prevMonth.educate}, ${thisMonth.educate}],
        ]);

        var options = {
          chart: {
            title: '지출 그래프',
          }
        };

        var chart = new google.charts.Bar(document.getElementById('columnchart_material'));
        
        var formatter = new google.visualization.NumberFormat({pattern: '###,###₩'});
        formatter.format(data, 1);
        formatter.format(data, 2);
        
        chart.draw(data, google.charts.Bar.convertOptions(options));
      }
    </script>
  </head>
  <body>
    <div id="columnchart_material" class="pt-2" style="width: 900px; height: 400px;"></div>
    <div class="prevMonth p-3">
    	<span>저번달 총 지출</span>
    	<c:set var="prevAll" value="${prevMonth.etc + prevMonth.culture + prevMonth.shopping + prevMonth.leisure
    	+ prevMonth.food + prevMonth.life + prevMonth.educate}"/>
    	<fmt:formatNumber value="${prevAll}" type="currency" /><br>
    	
    	<span>이번달 총 지출</span>
    	<c:set var="thisAll" value="${thisMonth.etc + thisMonth.culture + thisMonth.shopping + thisMonth.leisure
    	+ thisMonth.food + thisMonth.life + thisMonth.educate}"/>
    	<fmt:formatNumber value="${thisAll}" type="currency" /><br>
    </div>
  </body>