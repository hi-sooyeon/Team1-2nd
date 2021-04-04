<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<ul class="nav navbar-nav side-nav">
	<li><a href="Ex02_JDBC_Btrap_Main.jsp"><i
			class="fa fa-fw fa-user-plus"></i> Main</a></li>
	<c:choose>
		<c:when test="${ not empty sessionScope.userid }">
			<c:if test="${sessionScope.userid eq 'admin'}">
				<li><a href="Ex03_Btrap_Memberlist.jsp"><i
					class="fa fa-fw fa-paper-plane-o"></i> 회원관리</a></li>
			</c:if>
		
		
			<li><a href="Ex02_JDBC_Btrap_Logout.jsp"><i
					class="fa fa-fw fa-paper-plane-o"></i> Logout</a></li>
		</c:when>
		<c:otherwise>
			<li><a href="Ex02_JDBC_Btrap_Login.jsp"><i
					class="fa fa-fw fa-paper-plane-o"></i> Login</a></li>
			<li><a href="Ex02_JDBC_Btrap_JoinForm.jsp"><i
					class="fa fa-fw fa fa-question-circle"></i> Register</a></li>
		</c:otherwise>
	</c:choose>
</ul>

