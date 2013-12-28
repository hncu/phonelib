<%@ page import="phonelibv2.ShiroUser" %>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'username', 'error')} required">
    <label for="username">
        <g:message code="user.username.label" default="Username" />
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="username" required="" value="${userInstance?.username}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'passwordHash', 'error')} required">
    <label for="password">Password</label>
    <span class="required-indicator">*</span>
    <g:passwordField name="password" value=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'passwordHash', 'error')} required">
    <label for="password">Confirm Password</label>
    <span class="required-indicator">*</span>
    <g:passwordField name="password2" value=""/>
</div>