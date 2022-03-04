<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true" %>

<jsp:include page="includes/head.jsp"/>

<body class="container mt-3">
	<div class="d-flex flex-wrap align-items-center justify-content-center justify-content-md-between py-3 mb-4">
		<h1 class="d-flex align-items-center text-dark text-decoration-none"><c:out value="${ book.title }"></c:out></h1>
		<div class="col-md-3 text-end">
			<a href="/books">Back</a>
		</div>
	</div>
	<div>
		<h3><c:out value="${ book.getUser().userName }"></c:out> read <c:out value="${ book.title }"></c:out> by <c:out value="${ book.author }"></c:out>.</h3>
		<h3>Here are <c:out value="${ book.getUser().userName }"></c:out>'s thoughts:</h3>
		<p>"<c:out value="${ book.thoughts }"></c:out>"</p>
	</div>
	<c:if test="${ user_id == book.getUser().id }">
		<a href="/books/${ book.id }/edit">Edit</a>		
	</c:if>
</body>
</html>