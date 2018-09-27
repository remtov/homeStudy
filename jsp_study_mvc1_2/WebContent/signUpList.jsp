<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/common.jsp"%>

<body>
	<div id="jb-container">
		<div id="jb-header">

			<jsp:include page="/top.jsp" />

			<div id="jb-content" style="position: relative; top: 30px;">
				<h2>Sign Up List</h2>
				<p>회원정보 리스트</p>



				<script type="text/javascript">
					var searchRequest = new XMLHttpRequest();
					var registerRequest = new XMLHttpRequest();//레지스터함수에서 사용할수있도록 생성해준다.

					function searchFunction() {
						searchRequest
								.open(
										"Post",
										"./UserSearchServlet?userName="
												+ encodeURIComponent(document
														.getElementById("userName").value),
										true);
						searchRequest.onreadystatechange = searchProcess;
						searchRequest.send(null);
					}

					function searchProcess() {
						var table = document.getElementById("ajaxTable");
						table.innerHTML = "";
						if (searchRequest.readyState == 4
								&& searchRequest.status == 200) {
							var object = eval('(' + searchRequest.responseText
									+ ')');
							var result = object.result;

							for (var i = 0; i < result.length; i++) {
								var row = table.insertRow(0);
								for (var j = 0; j < result[i].length; j++) {
									var cell = row.insertCell(j);
									cell.innerHTML = result[i][j].value;
								}
							}
						}
					}

					function registerFunction() {
						registerRequest
								.open(
										"Post",
										"./UserRegisterServlet?userName="
												+ encodeURIComponent(document
														.getElementById("registerName").value)
												+ "&userAge="
												+ encodeURIComponent(document
														.getElementById("registerAge").value)
												+ "&userGender="
												+ encodeURIComponent($(
														'input[name=registerGender]:checked')
														.val())
												+ "&userEmail="//젠더는 아이디대신 네임을 주었기때문에 조금다른방식으로한다.
												+ encodeURIComponent(document
														.getElementById("registerEmail").value),
										true);//주의:같은거라해도 아이디는 고유하기때문에 인서트와 셀렉트는 명칭이달라져야 한다.

						registerRequest.onreadystatechange = registerProcess;
						registerRequest.send(null);
					}
					function registerProcess() {
						if (registerRequest.readyState == 4
								&& registerRequest.status == 200) {
							var result = registerRequest.responseText;
							if (result != 1) {
								alert('insert failed.');
							} else {//등록이 잘된 경우에 새로 입력할수있도록 인풋을 전부 비워준다.
								var userName = document
										.getElementById("userName");
								var registerName = document
										.getElementById("registerName");
								var registerAge = document
										.getElementById("registerAge");
								var registerEmail = document
										.getElementById("registerEmail");
								userName.value = "";
								registerName.value = "";
								registerAge.value = "";
								registerEmail.value = "";
								searchFunction();//등록이끝난후 새롭게추가된 회원까지포함한 내용을 화면에 띄워준다.

							}
						}
					}
					window.onload = function() {
						searchFunction();
					}
				</script>

				</head>
				<body>
					<br>
					<div class="container">

						<table class="table"
							style="text-align: center; border: 1px solid #dddddd">
							<thead>
								<tr>
									<th colspan="2" class="table"
										style="background-color: #fafafa; text-align: center;">회원
										등록 양식</th>
								</tr>

							</thead>
							<tbody>
								<tr>
									<td style="background-color: #fafafa; text-align: center;"><h5>이름</h5></td>
									<td><input class="form-control" type="text"
										id="registerName" size="20"></td>
								</tr>
								<tr>
									<td style="background-color: #fafafa; text-align: center;"><h5>나이</h5></td>
									<td><input class="form-control" type="text"
										id="registerAge" size="20"></td>
								</tr>
								<tr>
									<td style="background-color: #fafafa; text-align: center;"><h5>성별</h5></td>
									<td><div class="form-group"
											style="text-align: center; margin: 0auto;">
											<div class="btn-group" data-toggle="buttons">
												<label class="btn btn-primary active"> <input
													type="radio" name="registerGender" autocomplete="off"
													value="남자" checked>남자

												</label> <label class="btn btn-primary"> <input type="radio"
													name="registerGender" autocomplete="off" value="여자">여자
												</label>

											</div>

										</div></td>
								</tr>
								<tr>
									<td style="background-color: #fafafa; text-align: center;"><h5>이메일</h5></td>
									<td><input class="form-control" type="text"
										id="registerEmail" size="20"></td>
								</tr>
								<tr>
									<td colspan="2"><button class="btn btn-primary pull-right"
											onclick="registerFunction();" type="button">등록</button></td>

								</tr>



							</tbody>
						</table>


					</div>
					<br>

					<div class="container">
						<div class="form-group row pull-right">
							<div class="col-xs-8">
								<input class="form-control" id="userName"
									onkeyup="searchFunction()" type="text" size="20">
							</div>
							<div class="col-xs-2">
								<button class="btn btn-primary" onclick="searchFunction();"
									type="button">검색</button>
							</div>
						</div>

						<table class="table"
							style="text-align: center; border: 1px solid #dddddd">
							<thead>
								<tr>
									<th style="background-color: #fafafa; text-align: center;">이름</th>
									<th style="background-color: #fafafa; text-align: center;">나이</th>
									<th style="background-color: #fafafa; text-align: center;">성별</th>
									<th style="background-color: #fafafa; text-align: center;">이메일</th>

								</tr>
							</thead>
							<tbody id="ajaxTable">

							</tbody>
						</table>
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



