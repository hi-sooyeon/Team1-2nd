<%@page import="kr.or.bit.utils.Singleton_Helper"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
if (session.getAttribute("userid") == null || !session.getAttribute("userid").equals("admin")) {
	//강제로 페이지 이동
	out.print("<script>location.href='Ex02_JDBC_Btrap_Login.jsp'</script>");
}

request.setCharacterEncoding("UTF-8");
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
						String name = request.getParameter("search");

						Connection conn = null;
						PreparedStatement pstmt = null;
						ResultSet rs = null;

						//where ename like '%길동%'
						conn = Singleton_Helper.getConnection("oracle");
						String sql = "select count(*) from koreamember where name like ?";
						String sql2 = "select id, name, email from koreamember where name like '%" + name + "%'";

						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, '%' + name + '%');
						rs = pstmt.executeQuery();
						int rowcount = 0;
						if (rs.next()) {
							rowcount = rs.getInt(1); //조회건수
						}
						%>
						<table class="table table-bordered table-hover">
								<colgroup>
									<col style="width:30%"/>
									<col style="width:30%"/>
								</colgroup>
								<thead>
									<tr>
										<th>ID</th>
										<th>이름</th>
										<th>Email</th>
									</tr>
								</thead>
								
								<tbody>
							<%
							if (rowcount > 0) {
								pstmt = conn.prepareStatement(sql2);
								rs = pstmt.executeQuery();
								while (rs.next()) {
									String id = rs.getString(1);
									String mname = rs.getString(2);
									String email = rs.getString(3);
							%>
							<tr>
								<td><%=id%></td>
								<td><%=mname%></td>
								<td><%=email%></td>
							</tr>
							<%
							} //end while
							out.print("<tr><td colspan='3'>");
							out.print("<b>[" + name + "] 조회결과" + rowcount + "건 조회</b>");
							out.print("</td></tr>");
							} else { //조회된 건수가 없는 경우
							out.print("<tr><td colspan='3'>");
							out.print("<b>[" + name + "] 조회결과가 없습니다</b>");
							out.print("</td></tr>");
							}
							%>
							</tbody>
						</table>
						<a href="Ex03_Btrap_Memberlist.jsp">회원 목록 페이지</a>
						<%
							Singleton_Helper.close(rs);
							Singleton_Helper.close(pstmt);
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