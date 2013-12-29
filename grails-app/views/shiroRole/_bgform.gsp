<%@ page import="phonelibv2.ShiroRole" %>



<div class="fieldcontain ${hasErrors(bean: shiroRoleInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="shiroRole.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${shiroRoleInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: shiroRoleInstance, field: 'permissions', 'error')} ">
	<label for="permissions">
		<g:message code="shiroRole.permissions.label" default="Permissions" />
		
	</label>
	
</div>

<div class="fieldcontain ${hasErrors(bean: shiroRoleInstance, field: 'users', 'error')} ">
	<label for="users">
		<g:message code="shiroRole.users.label" default="Users" />
		
	</label>
	
</div>

