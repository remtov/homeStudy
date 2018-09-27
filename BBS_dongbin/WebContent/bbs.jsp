<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="java.util.ArrayList"%>


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
		/* 현재게시판이 몇번째인지 알수있게하는 로직 */
		int pageNumber = 1;//처음에는 1이니까 기본을 선언
		if (request.getParameter("pageNumber") != null) {
			//파라미터로 페이지넘버라는게 넘어 왔다면
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));//해당 파라미터값을 페이지넘버에 넣는다.
		}
		/* 현재게시판이 몇번째인지 알수있게하는 로직 */
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

		<div class="container">
			<div class="row">

				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd">
					<!-- 튜플 줄무늬 테이블 -->
					<thead>
						<tr>
							<th style="background-color: #eeeeee; text-align: center;">번호</th>
							<th id="myTh">제목</th>
							<th id="myTh">작성자</th>
							<th id="myTh">작성일</th>

						</tr>
					</thead>
					<tbody>
						<!-- 데이터베이스에서 게시글을 뽑아오는 로직 -->
						<%
							BbsDAO bbsDAO = new BbsDAO();//인스턴스생성
							ArrayList<Bbs> list = bbsDAO.getList(pageNumber);//리스트를생성
							//가져온 목록을 하나씩 출력한다.
							for (int i = 0; i < list.size(); i++) {
						%>

						<tr>

							<td><%=list.get(i).getBbsID()%></td>
							<!-- 현재 게시물에 대한 정보를 가져올수있게한다. -->

							<td><a href="view.jsp?bbsID=<%=list.get(i).getBbsID()%>">
									<%=list.get(i).getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
						.replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></a></td>
							<!-- 제목을 누르면 해당 게시글로이동할 수 있게 링크를 걸어준다. -->
							<td><%=list.get(i).getUserID()%></td>
							<td><%=list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13) + "시"
						+ list.get(i).getBbsDate().substring(14, 16) + "분"%></td>
							<!-- 시간은 우리가 필요한 정보만 편집하는 로직을 추가한다. -->

						</tr>

						<%
							}
						%>
						<!-- 데이터베이스에서 게시글을 뽑아오는 로직 -->


					</tbody>

				</table>
				<!-- 게시물 밑에 페이지넘버를 구현하는 로직 -->
				<%
					if (pageNumber != 1) {//페이지 넘버가 1이 아니라면 이전페이지로 갈수있는 길이 필요하다.
				%>

				<a href="bbs.jsp?pageNumber=<%=pageNumber - 1%>"
					class="btn btn-success btn-arraw-left">이전</a>

				<%
					}
					if (bbsDAO.nextPage(pageNumber + 1)) {//다음 페이지가 존재하는 지 물어봄
				%>


				<a href="bbs.jsp?pageNumber=<%=pageNumber + 1%>"
					class="btn btn-success btn-arraw-right">다음</a>


				<%
					}
				%>
				<!-- 게시물 밑에 페이지넘버를 구현하는 로직 -->
				<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
			</div>

		</div>

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