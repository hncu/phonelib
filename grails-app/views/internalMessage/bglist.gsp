
<%@ page import="phonelibv2.InternalMessage" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="bgmain">
		<g:set var="entityName" value="${message(code: 'internalMessage.label', default: 'InternalMessage')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-internalMessage" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/bgindex.gsp')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="bgcreate"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-internalMessage" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'internalMessage.dateCreated.label', default: 'Date Created')}" />
					
						<g:sortableColumn property="message" title="${message(code: 'internalMessage.message.label', default: 'Message')}" />
					
						<th><g:message code="internalMessage.recipient.label" default="Recipient" /></th>
					
						<th><g:message code="internalMessage.sender.label" default="Sender" /></th>
					
						<g:sortableColumn property="statue" title="${message(code: 'internalMessage.statue.label', default: 'Statue')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${internalMessageInstanceList}" status="i" var="internalMessageInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="bgshow" id="${internalMessageInstance.id}">${fieldValue(bean: internalMessageInstance, field: "dateCreated")}</g:link></td>
					
						<td>${fieldValue(bean: internalMessageInstance, field: "message")}</td>
					
						<td>${fieldValue(bean: internalMessageInstance, field: "recipient.username")}</td>
					
						<td>${fieldValue(bean: internalMessageInstance, field: "sender.username")}</td>
					
						<td><g:formatBoolean boolean="${internalMessageInstance.statue}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${internalMessageInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
