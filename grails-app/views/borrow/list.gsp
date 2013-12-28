
<%@ page import="phonelibv2.Borrow" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'borrow.label', default: 'Borrow')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-borrow" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-borrow" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="borrow.book.label" default="Book" /></th>
					
						<th><g:message code="borrow.borrower.label" default="Borrower" /></th>
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'borrow.dateCreated.label', default: 'Date Created')}" />
					
						<th><g:message code="borrow.owner.label" default="Owner" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${borrowInstanceList}" status="i" var="borrowInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${borrowInstance.id}">${fieldValue(bean: borrowInstance, field: "book")}</g:link></td>
					
						<td>${fieldValue(bean: borrowInstance, field: "borrower")}</td>
					
						<td><g:formatDate date="${borrowInstance.dateCreated}" /></td>
					
						<td>${fieldValue(bean: borrowInstance, field: "owner")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${borrowInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
