<%@page import="kr.or.bit.utils.Singleton_Helper"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
/*  
	회원 상세 페이지 (id 컬럼 PK)
	1.권한 검사
	2.id 값 받기 (request.getparameter("id")) >> 한글처리
	3.select id,pwd,name,age,gender,email from koreamember where id=?
	4.id primary key (데이터 1건 보장)
	5.화면 출력 UI 구성
*/
/*  
1.관리자만 접근 가능한 페이지
2.로그인한 일반 회원이 주소값을 외워서 ... 접근불가 
3.그러면  회원에 관련되 모든 페이지 상단에는 아래 코드를 ..... : sessionCheck.jsp >> include 
*/
if (session.getAttribute("userid") == null || !session.getAttribute("userid").equals("admin")) {
	//강제로 페이지 이동
	out.print("<script>location.href='Ex02_Btrap_JDBC_Login.jsp'</script>");
}
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
					<div class="col-sm-10 col-md-10 well" id="content">
						<%
						String id = request.getParameter("id");

						Connection conn = null;
						PreparedStatement pstmt = null;
						ResultSet rs = null;

						try {
							conn = Singleton_Helper.getConnection("oracle");
							String sql = "select id,pwd,name,age,gender,email from koreamember where id=?";
							pstmt = conn.prepareStatement(sql);

							pstmt.setString(1, id);

							rs = pstmt.executeQuery();
							//rs.next(); 추후에 데이터 1건 경우  (while 없이 )
							while (rs.next()) {
						%>
						<table class="table table-bordered table-hover">
							<colgroup>
								<col style="width: 20%" />
								<col style="width: auto" />
							</colgroup>

							<tbody>
								<tr>
									<td>아이디</td>
									<td><%=rs.getString("id")%></td>
								</tr>
								<tr>
									<td>비번</td>
									<td><%=rs.getString("pwd")%></td>
								</tr>
								<tr>
									<td>이름</td>
									<td><%=rs.getString("name")%></td>
								</tr>
								<tr>
									<td>나이</td>
									<td><%=rs.getString("age")%></td>
								</tr>
								<tr>
									<td>성별</td>
									<td><%=rs.getString("gender")%></td>
								</tr>
								<tr>
									<td>이메일</td>
									<td><%=rs.getString("email")%></td>
								</tr>
							</tbody>
							<tr>
								<td colspan="2"><a href="Ex03_Btrap_Memberlist.jsp">목록가기</a></td>
							</tr>
						</table>
						<%
						}

						} catch (Exception e) {

						} finally {
						Singleton_Helper.close(rs);
						Singleton_Helper.close(pstmt);
						}
						%>
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