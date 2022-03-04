<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true" %>

<jsp:include page="includes/head.jsp"/>

<body class="container mt-3">
	<div class="d-flex flex-wrap align-items-center justify-content-center justify-content-md-between py-3 mb-4">
		<h1 class="d-flex align-items-center text-dark text-decoration-none">Welcome, <c:out value="${user.userName}"></c:out>!</h1>
		<div class="col-md-3 text-end">
			<a href="/logout">Logout</a>
			<a href="/books/new">+ Add to my shelf</a>
		</div>
	</div>
	
	<div>
		<h2 class="mb-3 text-primary">Bookshelf</h2>
		<h3>Available Books:</h3>
		<table class="table">
		  <thead>
		    <tr>
		      <th scope="col">ID</th>
		      <th scope="col">Title</th>
		      <th scope="col">Author Name</th>
		      <th scope="col">Owner</th>	
		      <th scope="col">Actions</th>
		      <th scope="col"></th>
		    </tr>
		  </thead>
		  <tbody>
			<c:forEach var="book" items="${ books }">
			<tr>
				<c:choose>
					<c:when test="${ book.getBorrower().id == null && user_id != book.getUser().id }">
						<td><c:out value="${ book.id }"></c:out></td>
						<td><a href="/books/${book.id}"><c:out value="${ book.title }"></c:out></a></td>
						<td><c:out value="${ book.author }"></c:out></td>
						<td><c:out value="${ book.getUser().userName }"></c:out></td>
						<td><a href="/books/${ book.id }/borrow">Borrow</a></td>
					</c:when>
					<c:when test = "${ book.getBorrower().id == null && user_id == book.getUser().id }">
						<td><c:out value="${ book.id }"></c:out></td>
						<td><a href="/books/${book.id}"><c:out value="${ book.title }"></c:out></a></td>
						<td><c:out value="${ book.author }"></c:out></td>
						<td><c:out value="${ book.getUser().userName }"></c:out></td>
						<td><a href="/books/${ book.id }/edit">Edit</a></td>	
		   				<td><a href="/books/${ book.id }/delete">Delete</a></td>	
					</c:when>
					<c:when test = "${ book.getBorrower().id != null && user_id != book.getUser().id }">
						
					</c:when>
					<c:when test = "${ book.getBorrower().id != null && user_id == book.getUser().id }">
						<td><c:out value="${ book.id }"></c:out></td>
						<td><a href="/books/${book.id}"><c:out value="${ book.title }"></c:out></a></td>
						<td><c:out value="${ book.author }"></c:out></td>
						<td><c:out value="${ book.getUser().userName }"></c:out></td>
						<td><a href="/books/${ book.id }/edit">Edit</a></td>	
		   				<td><a href="/books/${ book.id }/delete">Delete</a></td>
					</c:when>
				</c:choose>
				
		    </tr>
			</c:forEach>
		  </tbody>
		</table>
	</div>
	
	<div>
		<h3>Books I'm Borrowing:</h3>
		<table class="table">
		  <thead>
		    <tr>
		      <th scope="col">ID</th>
		      <th scope="col">Title</th>
		      <th scope="col">Author Name</th>
		      <th scope="col">Owner</th>	
		      <th scope="col">Actions</th>
		    </tr>
		  </thead>
		  <tbody>
			<c:forEach var="borrowed_book" items="${ borrowed_books }">
			<tr>
		      <td><c:out value="${ borrowed_book.id }"></c:out></td>
		      <td><a href="/books/${borrowed_book.id}"><c:out value="${ borrowed_book.title }"></c:out></a></td>
		      <td><c:out value="${ borrowed_book.author }"></c:out></td>
		      <td><c:out value="${ borrowed_book.getUser().userName }"></c:out></td>
		      <td><a href="/books/${ borrowed_book.id }/return">Return</a></td>
		    </tr>
			</c:forEach>	
		  </tbody>
		</table>
	</div>
	
</body>
</html>