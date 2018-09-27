<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%><!-- // 자바스크립트 문장을 작성하기 위해 사용하는것 -->
<%
	request.setCharacterEncoding("UTF-8");
%>
<!-- 건너오는 데이터를 변환해주는 역할 -->

<jsp:useBean id="user" class="user.User" scope="page" />
<!-- 유저클래스를 빈즈처럼 사용한다 페이지스코프로 이페이지에서만 쓸것을알린다 -->
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<!-- 로그인 페이지에서 넘겨준 아이디와 비밀번호를 받는다. -->

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>JSP 게시판 웹 사이트</title>
</head>
<body>

	<%
		/* 세션관리로직 */
		String userID = null;
		if (session.getAttribute("userID") != null) { //세션부여를 받은 회원들은
			userID = (String) session.getAttribute("userID");//해당 할당된 세션의 값을 넣어준다. 

		}
		if (userID != null) { //세션받은 경우에
			PrintWriter script = response.getWriter();
			script.println("<script>");//스크립트 문장을 유동적으로 실행할 수 있게 한다.
			script.println("alert('이미 로그인이 되어 있습니다.')");
			script.println("location.href = 'main.jsp'");//틀렸으므로 이전페이지로 보낸다.
			script.println("</script>");

		}
		/* 세션관리로직 */

		/* 로그인시도 로직 */
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword());//로그인페이지에서 넘긴 정보를 바탕으로 로그인함수에 넣는다.
		//로그인함수에담긴 유저다오를 통해 -2~1까지의 프리페어정보가 결과값에 담긴다.
		if (result == 1) {

			session.setAttribute("userID", user.getUserID());//접속한 회원에게 세션부여하기
			//세션부여받은 회원은 로그인회원가입을 비활성화시키고 로그아웃과 로그인고유활동을 활성화시킨다.

			PrintWriter script = response.getWriter();
			script.println("<script>");//스크립트 문장을 유동적으로 실행할 수 있게 한다.
			script.println("location.href = 'main.jsp'");//로그인이 성공했을 때  메인으로 가게한다.
			script.println("</script>");

		} else if (result == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");//스크립트 문장을 유동적으로 실행할 수 있게 한다.
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()");//틀렸으므로 이전페이지로 보낸다.

			script.println("</script>");

		} else if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");//스크립트 문장을 유동적으로 실행할 수 있게 한다.
			script.println("alert('존재하지 않는 아이디입니다.')");
			script.println("history.back()");//틀렸으므로 이전페이지로 보낸다.

			script.println("</script>");
		} else if (result == -2) {
			PrintWriter script = response.getWriter();
			script.println("<script>");//스크립트 문장을 유동적으로 실행할 수 있게 한다.
			script.println("alert('데이터 베이스 오류가 발생했습니다.')");
			script.println("history.back()");//틀렸으므로 이전페이지로 보낸다.

			script.println("</script>");
			/* 로그인시도 로직 */
		}
	%>


</body>
</html>