<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="common/common.jsp"></jsp:include>
</head>
<body>
	<div id="throbber" style="display: none; min-height: 120px;"></div>
	<div id="noty-holder"></div>
	<div id="wrapper">
		<!-- Navigation -->
		<jsp:include page="common/Top_Btrap.jsp"></jsp:include>

		<div id="page-wrapper">
			<div class="container-fluid">
				<!-- Page Heading -->
				<div class="row" id="main">
					<div class="col-sm-10 col-md-10 well" id="content">
						<h1>
						<%
							String id = null;
							id = (String)session.getAttribute("userid");
							
							if(id != null){
								//회원
								out.print(id + " 회원님 방가방가^^<br>");
								if(id.equals("admin")){
									out.print("<a href='Ex03_Btrap_Memberlist.jsp'>회원관리</a>");
								}
							}else{
								//로그인 하지 않은 사용자
								//메인 페이지는 회원만 볼수 있어요 (강제 링크 추가)
								out.print("사이트 방문을 환영합니다 ^^ <br>회원가입 좀 하지 ...");
							}
						%>
						</h1>
					</div>
				</div>
				<!-- /.row -->
			</div>
			<!-- /.container-fluid -->
		</div>
		<!-- /#page-wrapper -->
	</div>
	<!-- /#wrapper -->

</body>
</html>


