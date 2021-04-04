<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="kr.or.bit.utils.Singleton_Helper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
/* 
회원정보 수정하기
1.DB 쿼리 : 2개 (수정정보 : select , 수정정보반영 : update)
 1.1 : select * from koreamember where id=?
 1.2 : update koreamember set ename=? where id=?		 
2.화면 1개(기존에 입력내용 보여주는 것)-> 처리 1개 (수정처리)
 2.1  DB select 한 결과 화면 출력 
   <input type="text" value="rs.getString(id)">
      수정안하고 .. 화면 .. 전송(x) : <td>rs.getString("id")</td>
      수정안하고 .. 화면 .. 전송   : <input type="text" value="rs.getString(id)" readonly>
      수정하고 ..화면  ..전송   :  <input type="text" value="rs.getString(id)">

*/
if (session.getAttribute("userid") == null || !session.getAttribute("userid").equals("admin")) {
	//강제로 페이지 이동
	out.print("<script>location.href='Ex02_JDBC_Btrap_Login.jsp'</script>");
}

request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
try {
	conn = Singleton_Helper.getConnection("oracle");
	String sql = "select id,pwd,name,age,trim(gender),email from koreamember where id=?";
	pstmt = conn.prepareStatement(sql);

	pstmt.setString(1, id);

	rs = pstmt.executeQuery();

	//while(rs.next())
	rs.next(); //1건 데이터가 있다면 전제조건
%>

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
						<h1>회원 정보 수정</h1>

						<form action="Ex03_Btrap_MemberEditok.jsp" method="post" name="modifyForm" id="modifyForm">
							<div class="form-group">
								<label class="mb-1"><strong>ID</strong></label> 
								<input type="text" id="id" name="id" class="form-control" placeholder="ID" value="<%=rs.getString(1)%>" readonly>
							</div>
							<div class="form-group">
								<label class="mb-1"><strong>PWD</strong></label> 
								<input type="password" id="pwd" name="pwd" class="form-control" placeholder="Password" value="<%=rs.getString(2)%>">
							</div>
							<div class="form-group">
								<label class="mb-1"><strong>Name</strong></label> 
								<input type="text" id="name" name="name" class="form-control" placeholder="Name" value="<%=rs.getString(3)%>">
							</div>
							<div class="form-group">
								<label class="mb-1"><strong>age</strong></label> 
								<input type="text" id="age" name="age" class="form-control" placeholder="Age" value="<%=rs.getString(4)%>">
							</div>
							<div class="form-group">
								<label class="mb-1"><strong>Gender</strong></label> 
								
								<label class="radio-inline" for="gender1"><input type="radio" name="gender" id="gender1" value="여" <%if (rs.getString(5).equals("여")) {%> checked <%}%>> 여자 </label>
								<label class="radio-inline" for="gender2"><input type="radio" name="gender" id="gender2" value="남" <%if (rs.getString(5).equals("남")) {%> checked <%}%>> 남자 </label>
							</div>
							<div class="form-group">
								<label class="mb-1"><strong>Email</strong></label> 
								<input type="text" id="email" name="email" class="form-control" placeholder="E-mail" value="<%=rs.getString(6)%>">
							</div>
							
							<div class="btn-group btn-group-lg">
									<button type="submit" class="btn btn-primary">수정하기</button>
									<button type="button" class="btn btn-danger" onclick="javascript:location.href='Ex03_Btrap_Memberlist.jsp'">리스트 이동</button>
								</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<%
} catch (Exception e) {

} finally {
Singleton_Helper.close(rs);
Singleton_Helper.close(pstmt);
}
%>
