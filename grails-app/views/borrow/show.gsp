
<%@ page import="phonelibv2.Borrow" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'borrow.label', default: 'Borrow')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-borrow" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-borrow" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list borrow">
			
				<g:if test="${borrowInstance?.book}">
				<li class="fieldcontain">
					<span id="book-label" class="property-label"><g:message code="borrow.book.label" default="Book" /></span>
					
						<span class="property-value" aria-labelledby="book-label"><g:link controller="book" action="show" id="${borrowInstance?.book?.id}">${borrowInstance?.book?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${borrowInstance?.borrower}">
				<li class="fieldcontain">
					<span id="borrower-label" class="property-label"><g:message code="borrow.borrower.label" default="Borrower" /></span>
					
						<span class="property-value" aria-labelledby="borrower-label"><g:link controller="shiroUser" action="bgshow" id="${borrowInstance?.borrower?.id}">${borrowInstance?.borrower?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${borrowInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="borrow.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${borrowInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${borrowInstance?.owner}">
				<li class="fieldcontain">
					<span id="owner-label" class="property-label"><g:message code="borrow.owner.label" default="Owner" /></span>
					
						<span class="property-value" aria-labelledby="owner-label"><g:link controller="shiroUser" action="bgshow" id="${borrowInstance?.owner?.id}">${borrowInstance?.owner?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${borrowInstance?.id}" />
					<g:link class="edit" action="edit" id="${borrowInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
