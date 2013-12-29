<%@ page import="phonelibv2.ShiroUser" %>


<div class="fieldcontain ${hasErrors(bean: shiroUserInstance, field: 'username', 'error')} required">
	<label for="username">
		<g:message code="shiroUser.username.label" default="Username" />
	</label>
	
	<g:textField name="username" maxlength="20" required="" value="${shiroUserInstance?.username}"/>
	 	<span class="required-indicator"><font color="red">&nbsp;&nbsp;*</font></span>
</div>

<div class="fieldcontain ${hasErrors(bean: shiroUserInstance, field: 'passwordHash', 'error')} required">
	<label for="passwordHash">
		<g:message code="shiroUser.passwordHash.label" default="Password Hash" />
	</label>
	<g:textField name="passwordHash" maxlength="30" required="" value="${shiroUserInstance?.passwordHash}"/>
		<span class="required-indicator"><font color="red">&nbsp;&nbsp;*</font></span>
</div>

<div class="fieldcontain ${hasErrors(bean: cmd, field: 'passwordAgain', 'error')} required">
	<label for="passwordHash">
		<g:message code="shiroUser.passwordHash.label" default="Password Hash" />
	</label>
	<g:textField name="passwordAgain" maxlength="30" required="" value="${fieldValue(bean:cmd,field:'passwordAgain') }"/>
		<span class="required-indicator"><font color="red">&nbsp;&nbsp;*</font></span>
</div>


<div class="fieldcontain ${hasErrors(bean: shiroUserInstance, field: 'email', 'error')} required">
	<label for="email">
		<g:message code="shiroUser.email.label" default="Email" />
	</label>
	<g:field type="email" name="email" required="" value="${shiroUserInstance?.email}"/>
		<span class="required-indicator"><font color="red">&nbsp;&nbsp;*</font></span>
</div>


