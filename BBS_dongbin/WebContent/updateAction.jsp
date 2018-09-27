<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO"%><!-- 게시글작성할수있는 데이터베이스의 내용이 담겨있는 객체 -->
<%@ page import="bbs.Bbs"%>
<%@ page import="java.io.PrintWriter"%><!-- // 자바스크립트 문장을 작성하기 위해 사용하는것 -->
<%
	request.setCharacterEncoding("UTF-8");
%>
<!-- 건너오는 데이터를 변환해주는 역할 -->

<%-- <jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<!-- bbs래스를 빈즈처럼 사용한다 페이지스코프로 이페이지에서만 쓸것을알린다 -->
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />
 빈즈를 쓰지 않을 경우 페이지 임포트 bbs.Bbs로 어느 정도는 대신 할 수 있다.--%>

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

		}

		/* 업데이트 액션을 위해 추가 되는 로직 */
		int bbsID = 0;//게시물번호에 0으로 세팅
		if (request.getParameter("bbsID") != null) {//매게변수 게시물넘버에 뭔가있다면
			bbsID = Integer.parseInt(request.getParameter("bbsID"));//넘어온 그것을 인트형으로 바꾸어 인스턴스화한다.

		}
		if (bbsID == 0) {//게시물넘버가 0이라면
			PrintWriter script = response.getWriter();
			script.println("<script>");//스크립트 문장을 유동적으로 실행할 수 있게 한다.
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bbs.jsp'");//로그인 페이지로 보낸다.
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);//글을 작성한 사람이 맞는지 확인한다.
		if (!userID.equals(bbs.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");//스크립트 문장을 유동적으로 실행할 수 있게 한다.
			script.println("alert('죄송합니다.권한이 없으십니다.')");
			script.println("location.href = 'bbs.jsp'");//로그인 페이지로 보낸다.
			script.println("</script>");
		}
		/* 업데이트 액션을 위해 추가 되는 로직 */

		else {//권한이 있는 사람은 아래 로직을 거쳐서 입력 확인한다.
			/* 로그인이 된경우 글쓰기로직 */
			if (request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null
					|| request.getParameter("bbsTitle").equals("")
					|| request.getParameter("bbsContent").equals("")) {//널값이나 빈문자열이 하나라도 있을 경우// 이 페이지에선 빈즈를 사용하지 않으므로, 타이틀과 콘텐츠로 넘어온값들을 다 비교할 필요가 있다.

				PrintWriter script = response.getWriter();
				script.println("<script>");//스크립트 문장을 유동적으로 실행할 수 있게 한다.
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");//틀렸으므로 이전페이지로 보낸다.

				script.println("</script>");

			} else {
				BbsDAO bbsDAO = new BbsDAO();
				int result = bbsDAO.update(bbsID, request.getParameter("bbsTitle"), request.getParameter("bbsContent"));
				//무언가가 입력되었다면 제목과내용 아이디를 결과에넣어 결과를 보낸다.

				//로그인함수에담긴 유저다오를 통해 -2~1까지의 프리페어정보가 결과값에 담긴다.
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");//스크립트 문장을 유동적으로 실행할 수 있게 한다.
					script.println("alert('죄송합니다. 데이터 오류로 인해 글 수정에 실패하였습니다.')");//함수에반환된 결과가 -1이라면 데이터오류가 확실하다
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