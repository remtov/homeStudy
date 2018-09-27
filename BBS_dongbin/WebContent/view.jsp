<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.Bbs"%><!-- 실제데이터베이스를 사용할수있도록 -->
<%@ page import="bbs.BbsDAO"%><!-- 데이터베이스 접근객체 -->

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

		/* 글 하나 보기를 위한 매개변수 및 기본세팅 */
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
		Bbs bbs = new BbsDAO().getBbs(bbsID);//유효한글 게시물넘버가 있다면 그것을 DAO를거쳐 bbs에 넣어준다.

		/* 글 하나 보기를 위한 매개변수 및 기본세팅 */
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
			<%
				if (userID == null) {//세션이 없다면, 즉 로그아웃된 사람이라면
			%>
			<!-- 아래사항이 보이도록하라 -->
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a> <!-- //아이콘같은것 -->
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul></li>
			</ul>
			<!-- 접속하기가 로그온이 되어 있지 않은 경우에만 나오도록 하는 로직 -->

			<%
				} else {
			%>
			<!-- 이곳은 로그인 된 사람만 볼 수 있는 영역 -->

			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a> <!-- //아이콘같은것 -->
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>

					</ul></li>
			</ul>




			<!-- 이곳은 로그인 된 사람만 볼 수 있는 영역 -->
			<%
				}
			%>


		</div>
	</nav>
	<!-- 내용이 입력 될 곳 -->



	<div id="myContent">
		<h1>게시판</h1>
		<h4>자유롭게 무언가를 올릴 수 있는 공간 입니다.</h4>

		<!-- 게시물 하나의 내용이 보여지는 영역 -->
		<div class="container">
			<div class="row">


				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd">
					<!-- 튜플 줄무늬 테이블 -->
					<thead>
						<tr>
							<th colspan="3"
								style="background-color: #eeeeee; text-align: center;">게시판
								글 보기</th>

						</tr>
					</thead>
					<tbody>
						<tr>
							<td id="myTextTitle">글 제목</td>
							<td colspan="2"><%=bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
					.replaceAll("\n", "<br>")%></td>
						</tr>
						<tr>
							<td>작성자</td>
							<td colspan="2"><%=bbs.getUserID()%></td>
						</tr>
						<tr>
							<td>작성일자</td>
							<td colspan="2"><%=bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + "시"
					+ bbs.getBbsDate().substring(14, 16) + "분"%></td>
						</tr>
						<tr>
							<td>내용</td>
							<td colspan="2" id="myTextArea"><%=bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
					.replaceAll("\n", "<br>")%></td>
							<!-- 리플레이스올 객체로 치환시킨다. 모든 HTML이 이해할수 있는 코드로 -->
				 		</tr>



					</tbody>

				</table>
				<a href="bbs.jsp" class="btn btn-primary">목록</a>
				<!-- 글에들어온 작성자가 본인일때 수정할 수 있게 하는 영역 -->
				<%
					if (userID != null && userID.equals(bbs.getUserID())) {
				%>
				<a href="update.jsp?bbsID=<%=bbsID%>" class="btn btn-primary">수정</a>
				<a href="deleteAction.jsp?bbsID=<%=bbsID%>" class="btn btn-primary">삭제
				</a>
				<!-- 삭제경로는 따로 보여지는게 필요없기때문에 엑션만존제하는 페이지로간다 -->
				<%
					}
				%>


				<!-- 글에들어온 작성자가 본인일때 수정할 수 있게 하는 영역 -->
				<input type="button" class="btn btn-primary pull-right" value="글쓰기"
					onclick="location.href='write.jsp'">



			</div>

		</div>
		<!-- 게시물 하나의 내용이 보여지는 영역 -->

	</div>



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