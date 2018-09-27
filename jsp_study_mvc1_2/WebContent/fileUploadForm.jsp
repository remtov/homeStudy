<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/common.jsp"%>

<body>
	<div id="jb-container">
		<div id="jb-header">

			<jsp:include page="/top.jsp" />

			<div id="jb-content">
				<div class="container">

					<div style="position:relative; top: 30px;">


						<form action="fileUpload.jsp" method="post"
							enctype="multipart/form-data">

							<h1>File Upload Sample</h1>
							<table class="table"
								style="text-align: center; border: 1px solid #dddddd">

								<tr>
									<td colspan="2" align="center">

										<h3 style="background-color: #fafafa; text-align: center;">파일
											업로드 폼</h3>
									</td>

								</tr>
								<tr>
									<td style="background-color: #fafafa; text-align: center;"><h5>올린
											사람</h5></td>
									<td><input class="form-control" type="text" name="name" /></td>
								</tr>

								<tr>
									<td style="background-color: #fafafa; text-align: center;"><h5>제목</h5></td>
									<td><input class="form-control" type="text" name="subject" /></td>
								</tr>
								<tr>
									<td style="background-color: #fafafa; text-align: center;"><h5>파일명1</h5></td>
									<td><input class="form-control" type="file"
										name="fileName1" /></td>
								</tr>
								<tr>
									<td style="background-color: #fafafa; text-align: center;"><h5>파일명2</h5></td>
									<td><input class="form-control" type="file"
										name="fileName2" /></td>
								</tr>

								<tr>

									<td colspan="2">
										<button class="btn btn-primary pull-right" type="submit">등록</button>
									</td>
								</tr>
							</table>


						</form>

					</div>

				</div>
			</div>
			<div id="jb-sidebar">
				<jsp:include page="/side.jsp" />


			</div>
			<div id="jb-footer">
				<jsp:include page="/bottom.jsp" />

			</div>
		</div>
</body>
</html>



