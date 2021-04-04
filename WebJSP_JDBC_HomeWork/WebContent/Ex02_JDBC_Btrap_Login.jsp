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
					<div class="col-sm-8 col-md-8 well" id="content">
						<h2>로그인 페이지</h2>
						<form action="Ex02_JDBC_Btrap_loginok.jsp" method="post" name="loginForm" id="loginForm">
							<div class="form-group">
								<label class="mb-1"><strong>아이디</strong></label> <input
									type="text" name="id" id="id" class="form-control" placeholder="Team1">
							</div>
							<div class="form-group">
								<label class="mb-1"><strong>비밀번호</strong></label> <input
									type="password" name="pwd" id="pwd" class="form-control" placeholder="Password">
							</div>
							
							<div class="form-group ">
								<div class="btn-group btn-group-lg">
									<button type="submit" class="btn btn-primary">Sign Me In</button>
									<button type="reset" class="btn btn-danger">Cancel</button>
								</div>
							</div>
						</form>


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
