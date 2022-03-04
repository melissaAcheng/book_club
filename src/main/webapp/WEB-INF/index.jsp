<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true" %>

<jsp:include page="includes/head.jsp"/>

<body class="container">
	<div class="mt-2">
		<h1>Book Club</h1>
		<p>A place for friends to share thoughts on books.</p>
	</div>
	
	<div class="row">
		<div class="col">
			<h1>Register</h1>
			<form:form class="mb-5" action="/register" method="post" modelAttribute="newUser">
				<div class="mb-3">
					<form:label path="userName" class="form-label">User Name</form:label>
					<form:errors path="userName" class="text-danger"/>
					<form:input class="form-control" path="userName"/>
				</div>
				<div class="mb-3">
					<form:label path="email" class="form-label">Email</form:label>
					<form:errors path="email" class="text-danger"/>
					<form:input type="email" class="form-control" path="email"/>
				</div>
				<div class="mb-3">
					<form:label path="password" class="form-label">Password</form:label>
					<form:errors path="password" class="text-danger"/>
					<form:input type="password" class="form-control" path="password"/>
				</div>
				<div class="mb-3">
					<form:label path="confirm" class="form-label">Confirm Password</form:label>
					<form:errors path="confirm" class="text-danger"/>
					<form:input type="password" class="form-control" path="confirm"/>
				</div>
				<input type="submit" value="Submit" />
			</form:form>
		</div>
		
		<div class="col">
			<h1>Login</h1>
			<form:form class="mb-5" action="/login" method="post" modelAttribute="newLogin">
				<div class="mb-3">
					<form:label path="email" class="form-label">Email</form:label>
					<form:errors path="email" class="text-danger"/>
					<form:input type="email" class="form-control" path="email"/>
				</div>
				<div class="mb-3">
					<form:label path="password" class="form-label">Password</form:label>
					<form:errors path="password" class="text-danger"/>
					<form:input type="password" class="form-control" path="password"/>
				</div>
				<input type="submit" value="Submit" />
			</form:form>
		</div>
	</div>
</body>
</html>