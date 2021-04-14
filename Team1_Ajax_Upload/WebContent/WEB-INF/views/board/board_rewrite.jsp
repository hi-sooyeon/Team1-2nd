<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- include libraries(jQuery, bootstrap) -->
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
	<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 
	
	<!-- include summernote css/js-->
	<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
	<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
	<title>Insert title here</title>
	<link rel="Stylesheet" 	href="${pageContext.request.contextPath}/style/default.css" />
	<SCRIPT type="text/javascript">
	function boardcheck() {
		if (!bbs.subject.value) {
			alert("제목을 입력하세요");
			bbs.subject.focus();
			return false;
		}
		if (!bbs.writer.value) {

			alert("이름을 입력하세요");
			bbs.writer.focus();
			return false;
		}
		/*
		if (!bbs.content.value) {
			alert("글 내용을 입력하세요");
			bbs.content.focus();
			return false;
		}
		*/

		if (!bbs.pwd.value) {
			alert("비밀번호를 입력하세요");
			bbs.pwd.focus();
			return false;
		}

		document.bbs.submit();

	}
</SCRIPT>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
	
	<c:set var="idx" value="${requestScope.idx}" />
	<c:set var="cpage" value="${requestScope.cp}" />
	<c:set var="pagesize" value="${requestScope.ps}" />
	<c:set var="subject" value="${requestScope.subject}" />
	
	<div id="pageContainer">
		<div style="padding-top: 25px; text-align: center">
			<form name="bbs" action="BoardRewriteOk.do" method="POST">
			
				<input type="hidden" name="cp" value="${cpage}" /> 
				<input type="hidden" name="ps" value="${pagesize}" /> 
				<input type="hidden" name="idx" value="${idx}" />
			

				<table width="95%" border="2" align="center">
					<tr>
						<td width="20%" align="center">제목</td>
						<td width="80%" align="left">
							<input type="text" name="subject" size="40" value="RE_${subject}">
						</td>

					</tr>

					<tr>
						<td width="20%" align="center">글쓴이</td>
						<td width="80%" align="left">
							<input type="text" name="writer" size="40"></td>

					</tr>

					<tr>
						<td width="20%" align="center">이메일</td>
						<td width="80%" align="left">
						<input type="text" name="email" size="40"></td>

					</tr>
					<tr>
						<td width="20%" align="center">홈페이지</td>
						<td width="80%" align="left">
						 <input type="text" name="homepage" size="40" value="http://"></td>

					</tr>
					<tr>
						<td width="20%" align="center">글내용</td>
						<td width="80%" align="left">
							<textarea rows="10" cols="60" name="content" id="summernote"></textarea></td>

					</tr>
					<tr>
						<td width="20%" align="center">비밀번호</td>
						<td width="80%" align="left">
							<input type="password" name="pwd" size="20"></td>

					</tr>
					<tr>
						<td width="20%" align="center">첨부파일</td>
						<td width="80%" align="left">
							<input type="file" name="filename"></td>
					</tr>
					<tr>
						<td colspan="2" align="center">
						<input type="button" 	value="글쓰기" onclick="boardcheck();" /> 
						<input type="reset" 	value="다시쓰기" />
						<a href="${pageContext.request.contextPath}/BoardList.do">목록으로 이동</a>
						</td>
						
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
<script type="text/javascript">
$(document).ready(function() {
	  $('#summernote').summernote();
	});
</script>
</html>
