
<%@ page import="phonelibv2.Own" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="bgmain">
		<g:set var="entityName" value="${message(code: 'own.label', default: 'Own')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-own" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/bgindex.gsp')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="bglist"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="bgcreate"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-own" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list own">
			
				<g:if test="${ownInstance?.book}">
				<li class="fieldcontain">
					<span id="book-label" class="property-label"><g:message code="own.book.label" default="Book" /></span>
					
						<span class="property-value" aria-labelledby="book-label"><g:link controller="book" action="bgshow" id="${ownInstance?.book?.id}">${ownInstance?.book?.title?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${ownInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="own.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${ownInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${ownInstance?.user}">
				<li class="fieldcontain">
					<span id="user-label" class="property-label"><g:message code="own.user.label" default="User" /></span>
					
						<span class="property-value" aria-labelledby="user-label"><g:link controller="shiroUser" action="bgshow" id="${ownInstance?.user?.id}">${ownInstance?.user?.username?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${ownInstance?.id}" />
					<g:link class="edit" action="bgedit" id="${ownInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="bgdelete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
