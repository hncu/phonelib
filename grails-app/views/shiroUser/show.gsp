
<%@ page import="phonelibv2.ShiroUser" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'shiroUser.label', default: 'ShiroUser')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-shiroUser" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-shiroUser" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list shiroUser">
			
				<g:if test="${shiroUserInstance?.passwordHash}">
				<li class="fieldcontain">
					<span id="passwordHash-label" class="property-label"><g:message code="shiroUser.passwordHash.label" default="Password Hash" /></span>
					
						<span class="property-value" aria-labelledby="passwordHash-label"><g:fieldValue bean="${shiroUserInstance}" field="passwordHash"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${shiroUserInstance?.username}">
				<li class="fieldcontain">
					<span id="username-label" class="property-label"><g:message code="shiroUser.username.label" default="Username" /></span>
					
						<span class="property-value" aria-labelledby="username-label"><g:fieldValue bean="${shiroUserInstance}" field="username"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${shiroUserInstance?.email}">
				<li class="fieldcontain">
					<span id="email-label" class="property-label"><g:message code="shiroUser.email.label" default="Email" /></span>
					
						<span class="property-value" aria-labelledby="email-label"><g:fieldValue bean="${shiroUserInstance}" field="email"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${shiroUserInstance?.borrower}">
				<li class="fieldcontain">
					<span id="borrower-label" class="property-label"><g:message code="shiroUser.borrower.label" default="Borrower" /></span>
					
						<g:each in="${shiroUserInstance.borrower}" var="b">
						<span class="property-value" aria-labelledby="borrower-label"><g:link controller="borrow" action="show" id="${b.id}">${b?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${shiroUserInstance?.own}">
				<li class="fieldcontain">
					<span id="own-label" class="property-label"><g:message code="shiroUser.own.label" default="Own" /></span>
					
						<g:each in="${shiroUserInstance.own}" var="o">
						<span class="property-value" aria-labelledby="own-label"><g:link controller="own" action="show" id="${o.id}">${o?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${shiroUserInstance?.owner}">
				<li class="fieldcontain">
					<span id="owner-label" class="property-label"><g:message code="shiroUser.owner.label" default="Owner" /></span>
					
						<g:each in="${shiroUserInstance.owner}" var="o">
						<span class="property-value" aria-labelledby="owner-label"><g:link controller="borrow" action="show" id="${o.id}">${o?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${shiroUserInstance?.permissions}">
				<li class="fieldcontain">
					<span id="permissions-label" class="property-label"><g:message code="shiroUser.permissions.label" default="Permissions" /></span>
					
						<span class="property-value" aria-labelledby="permissions-label"><g:fieldValue bean="${shiroUserInstance}" field="permissions"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${shiroUserInstance?.recipient}">
				<li class="fieldcontain">
					<span id="recipient-label" class="property-label"><g:message code="shiroUser.recipient.label" default="Recipient" /></span>
					
						<g:each in="${shiroUserInstance.recipient}" var="r">
						<span class="property-value" aria-labelledby="recipient-label"><g:link controller="internalMessage" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${shiroUserInstance?.roles}">
				<li class="fieldcontain">
					<span id="roles-label" class="property-label"><g:message code="shiroUser.roles.label" default="Roles" /></span>
					
						<g:each in="${shiroUserInstance.roles}" var="r">
						<span class="property-value" aria-labelledby="roles-label"><g:link controller="shiroRole" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${shiroUserInstance?.sender}">
				<li class="fieldcontain">
					<span id="sender-label" class="property-label"><g:message code="shiroUser.sender.label" default="Sender" /></span>
					
						<g:each in="${shiroUserInstance.sender}" var="s">
						<span class="property-value" aria-labelledby="sender-label"><g:link controller="internalMessage" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${shiroUserInstance?.id}" />
					<g:link class="edit" action="edit" id="${shiroUserInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
