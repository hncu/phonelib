
<%@ page import="phonelibv2.InternalMessage" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'internalMessage.label', default: 'InternalMessage')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-internalMessage" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-internalMessage" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list internalMessage">
			
				<g:if test="${internalMessageInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="internalMessage.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${internalMessageInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${internalMessageInstance?.message}">
				<li class="fieldcontain">
					<span id="message-label" class="property-label"><g:message code="internalMessage.message.label" default="Message" /></span>
					
						<span class="property-value" aria-labelledby="message-label"><g:fieldValue bean="${internalMessageInstance}" field="message"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${internalMessageInstance?.recipient}">
				<li class="fieldcontain">
					<span id="recipient-label" class="property-label"><g:message code="internalMessage.recipient.label" default="Recipient" /></span>
					
						<span class="property-value" aria-labelledby="recipient-label"><g:link controller="shiroUser" action="bgshow" id="${internalMessageInstance?.recipient?.id}">${internalMessageInstance?.recipient?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${internalMessageInstance?.sender}">
				<li class="fieldcontain">
					<span id="sender-label" class="property-label"><g:message code="internalMessage.sender.label" default="Sender" /></span>
					
						<span class="property-value" aria-labelledby="sender-label"><g:link controller="shiroUser" action="bgshow" id="${internalMessageInstance?.sender?.id}">${internalMessageInstance?.sender?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${internalMessageInstance?.statue}">
				<li class="fieldcontain">
					<span id="statue-label" class="property-label"><g:message code="internalMessage.statue.label" default="Statue" /></span>
					
						<span class="property-value" aria-labelledby="statue-label"><g:formatBoolean boolean="${internalMessageInstance?.statue}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${internalMessageInstance?.id}" />
					<g:link class="edit" action="edit" id="${internalMessageInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
