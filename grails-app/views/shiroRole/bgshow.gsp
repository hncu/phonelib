
<%@ page import="phonelibv2.ShiroRole" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="bgmain">
		<g:set var="entityName" value="${message(code: 'shiroRole.label', default: 'ShiroRole')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-shiroRole" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/bgindex.gsp')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="bglist"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="bgcreate"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-shiroRole" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list shiroRole">
			
				<g:if test="${shiroRoleInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="shiroRole.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${shiroRoleInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${shiroRoleInstance?.permissions}">
				<li class="fieldcontain">
					<span id="permissions-label" class="property-label"><g:message code="shiroRole.permissions.label" default="Permissions" /></span>
					
						<span class="property-value" aria-labelledby="permissions-label"><g:fieldValue bean="${shiroRoleInstance}" field="permissions"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${shiroRoleInstance?.users}">
				<li class="fieldcontain">
					<span id="users-label" class="property-label"><g:message code="shiroRole.users.label" default="Users" /></span>
					
						<g:each in="${shiroRoleInstance.users}" var="u">
						<span class="property-value" aria-labelledby="users-label"><g:link controller="shiroUser" action="bgshow" id="${u.id}">${u?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${shiroRoleInstance?.id}" />
					<g:link class="edit" action="bgedit" id="${shiroRoleInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="bgdelete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
