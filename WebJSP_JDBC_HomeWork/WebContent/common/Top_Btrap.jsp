<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
	<!-- Brand and toggle get grouped for better mobile display -->
	<div class="navbar-header">
		<button type="button" class="navbar-toggle" data-toggle="collapse"
			data-target=".navbar-ex1-collapse">
			<span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span>
			<span class="icon-bar"></span> <span class="icon-bar"></span>
		</button>
		<a class="navbar-brand" href="Ex02_JDBC_Btrap_Main.jsp">
			<img src="common/new_team1_logo.png" alt="LOGO" style="width: 200px;">
		</a>
	</div>
	
	
	<!-- Top Menu Items -->
	<ul class="nav navbar-left top-nav">
		<li>
			<c:choose>
				<c:when test="${not empty sessionScope.userid}">
					<a style="" href="javscript:void(0);">로그인 상태입니다!</a>
				</c:when>
				<c:otherwise>
					<a href="javscript:void(0);">미로그인 상태입니다!</a>
				</c:otherwise>
			</c:choose>
		</li>
	</ul>
	
	<!-- Top Menu Items -->
	<ul class="nav navbar-right top-nav">
		<li><a href="#" data-placement="bottom" data-toggle="tooltip"
			data-original-title="Stats"><i class="fa fa-bar-chart-o"></i> </a></li>
		<li class="dropdown"><a href="#" class="dropdown-toggle"
			data-toggle="dropdown"><c:out value="${ empty sessionScope.userid ? '': sessionScope.userid }"/> <b class="fa fa-angle-down"></b></a>
			<ul class="dropdown-menu">
				<li><a href="Ex02_JDBC_Btrap_Logout.jsp"><i class="fa fa-fw fa-power-off"></i>Logout</a></li>
			</ul>
		</li>
	</ul>
	<!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
	<div class="collapse navbar-collapse navbar-ex1-collapse">
		<jsp:include page="/common/Left_btrap.jsp"></jsp:include>

	</div>
	<!-- /.navbar-collapse -->
</nav>