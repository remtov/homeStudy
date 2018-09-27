<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO"%><!-- 게시글작성할수있는 데이터베이스의 내용이 담겨있는 객체 -->
<%@ page import="java.io.PrintWriter"%><!-- // 자바스크립트 문장을 작성하기 위해 사용하는것 -->
<%
	request.setCharacterEncoding("UTF-8");
%>
<!-- 건너오는 데이터를 변환해주는 역할 -->

<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<!-- bbs래스를 빈즈처럼 사용한다 페이지스코프로 이페이지에서만 쓸것을알린다 -->
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />


<!-- 로그인 페이지에서 넘겨준 아이디와 비밀번호를 받는다. -->

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>JSP 게시판 웹 사이트</title>
</head>
<body>

	<%
		String userID = null;
		if (session.getAttribute("userID") != null) { //세션부여를 받은 회원들은
			userID = (String) session.getAttribute("userID");//해당 할당된 세션의 값을 넣어준다. 

		}
		if (userID == null) { //로그인하지 않은 경우
			PrintWriter script = response.getWriter();
			script.println("<script>");//스크립트 문장을 유동적으로 실행할 수 있게 한다.
			script.println("alert('죄송합니다. 로그인 부탁 드립니다.')");
			script.println("location.href = 'login.jsp'");//로그인 페이지로 보낸다.
			script.println("</script>");

		} else {
			/* 로그인이 된경우 글쓰기로직 */
			if (bbs.getBbsTitle() == null || bbs.getBbsContent() == null) {

				PrintWriter script = response.getWriter();
				script.println("<script>");//스크립트 문장을 유동적으로 실행할 수 있게 한다.
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");//틀렸으므로 이전페이지로 보낸다.

				script.println("</script>");

			} else {
				BbsDAO bbsDAO = new BbsDAO();
				int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
				//무언가가 입력되었다면 제목과내용 아이디를 결과에넣어 결과를 보낸다.

				//로그인함수에담긴 유저다오를 통해 -2~1까지의 프리페어정보가 결과값에 담긴다.
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");//스크립트 문장을 유동적으로 실행할 수 있게 한다.
					script.println("alert('죄송합니다. 데이터베이스 오류로 글쓰기에 실패하였습니다.')");//함수에반환된 결과가 -1이라면 데이터오류가 확실하다
					script.println("history.back()");//틀렸으므로 이전페이지로 보낸다.
					script.println("</script>");
				} else {//-1이 아닌경우는 전부 글쓰기가 완료된것으로 본다.

					PrintWriter script = response.getWriter();
					script.println("<script>");//스크립트 문장을 유동적으로 실행할 수 있게 한다.
					script.println("location.href='bbs.jsp'");//게시판 작성후 게시판메인으로 돌려보낸다.
					script.println("</script>");
					/* 로그인이 된경우 글쓰기로직 */
				}
			}
		}
	%>


</body>
</html>