<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String rPath = request.getContextPath();
	String title = "J1's JSP Study Page";
	String uri = request.getRequestURI();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title><%=title%></title>
<link href="<%=rPath%>/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=rPath%>/css/simple-sidebar.css" rel="stylesheet" />
<link href="<%=rPath%>/css/common.css" rel="stylesheet" />
<script src="<%=rPath%>/vendor/jquery/jquery.min.js"></script>
<script src="<%=rPath%>/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="<%=rPath%>/vendor/common.js"></script>

<style>
#jb-container {
	width: 100%;
	border: 0px solid #bcbcbc;
}

#jb-header {
	width: 100%;
	padding: 0px;
	border: 0px solid #bcbcbc;
}

#jb-content {
	width: 100%;
	padding: 20px;
	margin-bottom: 20px;
	float: right;
	border: 0px solid #bcbcbc;
}

#jb-sidebar {
	width: 70%;
	padding: 20px;
	margin-bottom: 20px;
	float: left;
	border: 0px solid #bcbcbc;
}

#jb-footer {
	clear: both;
	padding: 20px;
	border: 1px solid #bcbcbc;
}
</style>




</head>


<body>

</body>
</html>