<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String rPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Top page</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/bootstrap-theme.min.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</head>
<body>
	<!-- 상단 네비게이션 바 -->
	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">

				<!-- 브라우저가 좁아졋을때 나오는 버튼(클릭시 메뉴출력) -->
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">

					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="signUpList.jsp">JSP Study Samples</a>
			</div>

			<div class="collapse navbar-collapse">
				<ul class="nav navbar-nav">
					<li class="active"><a href="<%=rPath%>/">홈으로</a></li>

					<li><a href="#about">J1's Portfolio</a></li>
					<li><a href="#contact">문의하기</a></li>
				</ul>
			</div>
		</div>
	</div>

	<div class="container">
		<div style="position: relative; top: 50px;">
			<img style="width: 100%; height: auto;"
				src="<%=rPath%>/img/backgroundImg03.jpg">

		</div>

	</div>
</body>
</html>



