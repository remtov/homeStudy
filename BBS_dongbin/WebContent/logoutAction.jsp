<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>JSP 게시판 웹 사이트</title>
</head>
<body>

	<%
		session.invalidate();
		/* 현재 접속한 회원의 세션을 빼앗음 */
	%>
	<script>
		location.href = 'main.jsp';
	</script>
	<!-- 세션빼앗고 다시 메인으로 돌려보낸다. -->

</body>
</html>