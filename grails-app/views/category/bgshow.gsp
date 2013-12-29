
<%@ page import="phonelibv2.Category" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="bgmain">
		<g:set var="entityName" value="${message(code: 'category.label', default: 'Category')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-category" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/bgindex.gsp')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="bglist"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="bgcreate"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-category" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list category">
			
				<g:if test="${categoryInstance?.cname}">
				<li class="fieldcontain">
					<span id="cname-label" class="property-label"><g:message code="category.cname.label" default="Cname" /></span>
					
						<span class="property-value" aria-labelledby="cname-label"><g:fieldValue bean="${categoryInstance}" field="cname"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${categoryInstance?.books}">
				<li class="fieldcontain">
					<span id="books-label" class="property-label"><g:message code="category.books.label" default="Books" /></span>
					
						<g:each in="${categoryInstance.books}" var="b">
						<span class="property-value" aria-labelledby="books-label"><g:link controller="book" action="bgshow" id="${b.id}">${b?.title?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${categoryInstance?.id}" />
					<g:link class="edit" action="bgedit" id="${categoryInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="bgdelete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
