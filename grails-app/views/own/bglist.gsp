
<%@ page import="phonelibv2.Own" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="bgmain">
		<g:set var="entityName" value="${message(code: 'own.label', default: 'Own')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-own" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/bgindex.gsp')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="bgcreate"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-own" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="own.book.label" default="Book" /></th>
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'own.dateCreated.label', default: 'Date Created')}" />
					
						<th><g:message code="own.user.label" default="User" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${ownInstanceList}" status="i" var="ownInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="bgshow" id="${ownInstance.id}">${fieldValue(bean: ownInstance, field: "book.title")}</g:link></td>
					
						<td><g:formatDate date="${ownInstance.dateCreated}" /></td>
					
						<td>${fieldValue(bean: ownInstance, field: "user.username")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${ownInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
