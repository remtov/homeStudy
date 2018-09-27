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
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />


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

		/* 회원가입처리로직 */
		if (user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null
				|| user.getUserGender() == null || user.getUserEmail() == null) {

			PrintWriter script = response.getWriter();
			script.println("<script>");//스크립트 문장을 유동적으로 실행할 수 있게 한다.
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");//틀렸으므로 이전페이지로 보낸다.

			script.println("</script>");

		} else {
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);//상부에 각각의 받은변수들의 집합 user인스턴스가 조인함수를 실행할수 있도록 한다.

			//로그인함수에담긴 유저다오를 통해 -2~1까지의 프리페어정보가 결과값에 담긴다.
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");//스크립트 문장을 유동적으로 실행할 수 있게 한다.
				script.println("alert('이미 존재하는 아이디입니다.')");//프라이머리 키로 등록된 아이디 중복에의해 제약사항이 데이터에있으므로 -1이 출력되는 상황은 아이디중복이 거의확실하다.
				script.println("history.back()");//틀렸으므로 이전페이지로 보낸다.
				script.println("</script>");
			} else {//-1이 아닌경우는 전부 회원가입이 이루어진 경우이므로 조건을 없엔다.

				session.setAttribute("userID", user.getUserID());//가입에 성공한 사용자에게 세션부여하기

				PrintWriter script = response.getWriter();
				script.println("<script>");//스크립트 문장을 유동적으로 실행할 수 있게 한다.
				script.println("location.href='main.jsp'");//0은 결과 만족 메인페이지로 보내준다.
				script.println("</script>");
				/* 회원가입처리로직 */
			}
		}
	%>


</body>
</html>