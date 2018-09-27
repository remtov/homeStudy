<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/common.jsp"%>

<body>
	<div id="jb-container">
		<div id="jb-header">

			<jsp:include page="/top.jsp" />


			<div id="jb-content">
				<h1>Hellow World</h1>
				<h4>Welcome to my Web that is JSP Study Pages</h4>
				<p>이곳은 현구의 JSP 연습공간입니다. 열시미 배우고 있습니다. 응원 부탁 드려요. Test Text after
					*.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean
					nec mollis nulla. Phasellus lacinia tempus mauris eu laoreet. Proin
					gravida velit dictum dui consequat malesuada. Aenean et nibh eu
					purus scelerisque aliquet nec non justo. Aliquam vitae aliquet
					ipsum. Etiam condimentum varius purus ut ultricies. Mauris id odio
					pretium, sollicitudin sapien eget, adipiscing risus.</p>
				<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
					Aenean nec mollis nulla. Phasellus lacinia tempus mauris eu
					laoreet. Proin gravida velit dictum dui consequat malesuada. Aenean
					et nibh eu purus scelerisque aliquet nec non justo. Aliquam vitae
					aliquet ipsum. Etiam condimentum varius purus ut ultricies. Mauris
					id odio pretium, sollicitudin sapien eget, adipiscing risus.</p>

			</div>
			<div id="jb-sidebar">
				<jsp:include page="/side.jsp" />


			</div>
			<div id="jb-footer">
				<jsp:include page="/bottom.jsp" />

			</div>
		</div>
	</div>
</body>
</html>



