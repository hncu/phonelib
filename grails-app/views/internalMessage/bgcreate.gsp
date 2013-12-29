<%@ page import="phonelibv2.InternalMessage" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="bgmain">
		<g:set var="entityName" value="${message(code: 'internalMessage.label', default: 'InternalMessage')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#create-internalMessage" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/bgindex.gsp')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="bglist"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="create-internalMessage" class="content scaffold-create" role="main">
			<h1><g:message code="default.create.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${internalMessageInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${internalMessageInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form action="bgsave" >
				<fieldset class="form">
					<g:render template="bgform"/>
				</fieldset>
				<fieldset class="buttons">
					<g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
