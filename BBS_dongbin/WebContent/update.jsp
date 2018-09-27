<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">

<link rel="stylesheet" href="style.css">
<!-- 개인 스타일시트 링크 -->

<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<!-- 로그인이 된 사람들은 로그인 정보를 담을 수 있도록한다. -->
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {//만약 세션이 널이 아니라면
			userID = (String) session.getAttribute("userID");//세션의 내용을 그대로 간직하도록한다
		}
		/* 업데이트에 사용될 로직 */
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");//스크립트 문장을 유동적으로 실행할 수 있게 한다.
			script.println("alert('죄송합니다. 로그인 부탁 드립니다.')");
			script.println("location.href = 'login.jsp'");//로그인 페이지로 보낸다.
			script.println("</script>");
		}
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

		/* 업데이트에 사용될 로직 */
	%>
	<!-- 로그인이 된 사람들은 로그인 정보를 담을 수 있도록한다. -->
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>

			</button>
			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹사이트</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<!-- 메뉴는 메인페이지이므로 메인을 활성화 -->
				<li class="active"><a href="bbs.jsp">게시판</a></li>

			</ul>
			<!-- 접속하기가 로그온이 되어 있지 않은 경우에만 나오도록 하는 로직 -->
			<%-- JSP 구문에서 이미 로그아웃 상태인 사람에 대해 이동처리를 해 주었으므로
		이 부분은 삭제한다. --%>
			<!-- 이곳은 로그인 된 사람만 볼 수 있는 영역 -->

			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a> <!-- //아이콘같은것 -->
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>

					</ul></li>
			</ul>




		</div>
	</nav>
	<!-- 내용이 입력 될 곳 -->



	<div id="myContent">
		<h1>게시판</h1>
		<h4>자유롭게 무언가를 올릴 수 있는 공간 입니다.</h4>

		<div class="container">
			<div class="row">

				<form method="post" action="updateAction.jsp?bbsID=<%=bbsID%>">
					<!-- "post" 보내지는 내용이 숨겨진다 -->
					<table class="table table-striped"
						style="text-align: center; border: 1px solid #dddddd">
						<!-- 튜플 줄무늬 테이블 -->
						<thead>
							<tr>
								<th colspan="2"
									style="background-color: #eeeeee; text-align: center;">게시판
									글 수정 양식</th>

							</tr>
						</thead>
						<tbody>
							<tr>
								<td><input type="text" class="form-control"
									placeholder="글 제목" name="bbsTitle" maxlength="50"
									value="<%=bbs.getBbsTitle()%>"></td>
							</tr>


							<tr>
								<td><textarea class="form-control" placeholder="글 내용"
										name="bbsContent" maxlength="2048" id="myTextArea" ><%=bbs.getBbsContent()%></textarea></td>
							</tr>
 
						</tbody>

					</table>
					<input type="submit" class="btn btn-primary pull-right" value="글 수정">

				</form>

			</div>

		</div>

	</div>

	<!-- 이곳은 로그인 된 사람만 볼 수 있는 영역 -->




	<div id="myHeader">
		<jsp:include page="/header.jsp" />
	</div>



	<div id="myFooter">
		<jsp:include page="/footer.jsp" />

	</div>






	<!-- 내용이 입력 될 곳 -->

	<!-- 하단부 스크립트 입력란 -->
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>
<!-- 하단부 스크립트 입력란 -->