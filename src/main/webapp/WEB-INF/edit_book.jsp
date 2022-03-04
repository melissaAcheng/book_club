<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true" %>

<jsp:include page="includes/head.jsp"/>

<body class="container mt-3">
	<div class="d-flex flex-wrap align-items-center justify-content-center justify-content-md-between py-3 mb-4">
		<h1 class="d-flex align-items-center text-dark text-decoration-none">Change Your Entry</h1>
		<div class="col-md-3 text-end">
			<a href="/books">Back</a>
		</div>
	</div>
	<div>
		<form:form action="/books/${ book.id }" method="post" modelAttribute="book">
			<input type="hidden" name="_method" value="put"/>
			<div class="mb-3">
				<form:label path="title" class="form-label">Title</form:label>
				<form:errors path="title" class="text-danger"/>
				<form:input class="form-control" path="title"/>
			</div>
			<div class="mb-3">
				<form:label path="author" class="form-label">Author</form:label>
				<form:errors path="author" class="text-danger"/>
				<form:input class="form-control" path="author"/>
			</div>
			<div class="mb-3">
				<form:label path="thoughts" class="form-label">Thoughts</form:label>
				<form:errors path="thoughts" class="text-danger"/>
				<form:textarea path="thoughts" class="form-control" cols="10" rows="5"/>
			</div>
			<input type="submit" value="Submit" />
		</form:form>
	</div>
</body>
</html>