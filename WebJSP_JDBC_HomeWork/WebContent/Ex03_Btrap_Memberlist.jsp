<%@page import="kr.or.bit.utils.Singleton_Helper"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
/*  
 1.관리자만 접근 가능한 페이지
 2.로그인한 일반 회원이 주소값을 외워서 ... 접근불가 
 3.그러면  회원에 관련되 모든 페이지 상단에는 아래 코드를 ..... : sessionCheck.jsp >> include 
*/
if (session.getAttribute("userid") == null || !session.getAttribute("userid").equals("admin")) {
	//강제로 페이지 이동
	//out.print("<script>location.href='Ex02_JDBC_Login.jsp'</script>");
	response.sendRedirect("Ex02_JDBC_Btrap_Login.jsp");
}
%>

<!DOCTYPE>
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
							Connection conn = null;
							PreparedStatement pstmt = null;
							ResultSet rs = null;
							try {
								conn = Singleton_Helper.getConnection("oracle");
								String sql = "select id, ip from koreamember";
								pstmt = conn.prepareStatement(sql);
								rs = pstmt.executeQuery();
							%>
							<table class="table table-bordered table-hover">
								<colgroup>
									<col style="width:30%"/>
									<col style="width:30%"/>
									<col style="width:20%"/>
									<col style="width:20%"/>
								</colgroup>
								<thead>
									<tr>
										<th colspan="4">회원리스트</th>
									</tr>
								</thead>
								
								<tbody>
								<%
								while (rs.next()) {
								%>
								<tr>
									<td><a
										href='Ex03_Btrap_MemberDetail.jsp?id=<%=rs.getString("id")%>'><%=rs.getString("id")%></a>
									</td>
									<td><%=rs.getString("ip")%></td>
									<td><a
										href="Ex03_Btrap_MemberDelete.jsp?id=<%=rs.getString("id")%>">[삭제]</a>
									</td>
									<td><a
										href="Ex03_Btrap_MemberEdit.jsp?id=<%=rs.getString("id")%>">[수정]</a>
									</td>
								</tr>
								<%
								}
								%>
								</tbody>
							</table>
							<form action="Ex03_Btrap_MemberSearch.jsp" id="searchForm" name="searchForm" method="post">
								<div class="form-group">
									<label for="searchName">회원명 <input type="text" id="searchName" name="search" class="form-control" style="width:300px;"></label> 
									<button type="submit" class="btn btn-primary">이름검색하기</button>
								</div>
							</form>
							<%
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