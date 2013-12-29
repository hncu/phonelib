<%@ page import="phonelibv2.ShiroUser" %>


<div class="fieldcontain ${hasErrors(bean: shiroUserInstance, field: 'username', 'error')} required">
	<label for="username">
		<g:message code="shiroUser.username.label" default="用户名" />
	</label>
	
	<g:textField name="username" maxlength="20" required="" value="${shiroUserInstance?.username}"/>
	 	<span class="required-indicator"><font color="red">&nbsp;&nbsp;*</font></span>
</div>

<div class="fieldcontain ${hasErrors(bean: shiroUserInstance, field: 'passwordHash', 'error')} required">
	<label for="passwordHash">
		<g:message code="shiroUser.passwordHash.label" default="密码" />
	</label>
	<g:passwordField name="passwordHash" maxlength="30" required="" value=""/>
		<span class="required-indicator"><font color="red">&nbsp;&nbsp;*</font></span>
</div>

<div class="fieldcontain ${hasErrors(bean: shiroUserInstance, field: 'passwordHash', 'error')} required">
	<label for="passwordHash">
		<g:message code="shiroUser.passwordHash.label" default="密码确认" />
	</label>
	<g:passwordField name="password2" maxlength="30" required="" value=""/>
		<span class="required-indicator"><font color="red">&nbsp;&nbsp;*</font></span>
</div>


<div class="fieldcontain ${hasErrors(bean: shiroUserInstance, field: 'email', 'error')} required">
	<label for="email">
		<g:message code="shiroUser.email.label" default="邮箱" />
	</label>
	<g:field type="email" name="email" required="" value="${shiroUserInstance?.email}"/>
		<span class="required-indicator"><font color="red">&nbsp;&nbsp;*</font></span>
</div>


