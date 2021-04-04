<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="common/common.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script type="text/javascript">
 //jquery 로 간단하게 유효성 check 하기
 $(function() {
  	$('#joinForm').submit(function() {
	   //alert("가입");
	if ($('#id').val() == "") { // 아이디 검사
    	alert('ID를 입력해 주세요.');
    	$('#id').focus();
    return false;
   } else if ($('#pwd').val() == "") { // 비밀번호 검사
    alert('PWD를 입력해 주세요.');
    $('#pwd').focus();
    return false;
   }else if ($('#mname').val() == "") { // 이름 검사
    alert('mname를 입력해 주세요.');
    $('#mname').focus();
    return false;
   }else if ($('#age').val() == "") { // 나이 검사
    alert('age를 입력해 주세요.');
    $('#age').focus();
    return false;
   }else if ($('#email').val() == "") { // 우편번호
    alert('email를 입력해 주세요.');
    $('#email').focus();
    return false;
   }
   
  });
 });
</script>
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
						<h1>회원 가입</h1>

						<form action="Ex02_JDBC_Btrap_JoinOK.jsp" method="post" name="joinForm"
							id="joinForm">
							<div class="form-group">
								<label class="mb-1"><strong>ID</strong></label> 
								<input type="text" id="id" name="id" class="form-control" placeholder="ID">
							</div>
							<div class="form-group">
								<label class="mb-1"><strong>PWD</strong></label> 
								<input type="password" id="pwd" name="pwd" class="form-control" placeholder="Password">
							</div>
							<div class="form-group">
								<label class="mb-1"><strong>Name</strong></label> 
								<input type="text" id="mname" name="mname" class="form-control" placeholder="Name">
							</div>
							<div class="form-group">
								<label class="mb-1"><strong>age</strong></label> 
								<input type="text" id="age" name="age" class="form-control" placeholder="Age">
							</div>
							<div class="form-group">
								<label class="mb-1"><strong>Gender</strong></label> 
								
								<label class="radio-inline" for="gender1"><input type="radio" name="gender" id="gender1" value="여" checked> 여자 </label>
								<label class="radio-inline" for="gender2"><input type="radio" name="gender" id="gender2" value="남"> 남자 </label>
							</div>
							<div class="form-group">
								<label class="mb-1"><strong>Email</strong></label> 
								<input type="text" id="email" name="email" class="form-control" placeholder="hello@team1.com">
							</div>
							
							<div class="form-group">
								<button type="submit" class="btn btn-primary btn-block">Sign up</button>
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


