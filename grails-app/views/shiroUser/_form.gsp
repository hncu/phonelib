<%@ page import="phonelibv2.ShiroUser" %>


<div class="fieldcontain ${hasErrors(bean: shiroUserInstance, field: 'username', 'error')} required">
	<label for="username">
		<g:message code="shiroUser.username.label" default="Username" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="username" maxlength="20" required="" value="${shiroUserInstance?.username}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: shiroUserInstance, field: 'passwordHash', 'error')} required">
	<label for="passwordHash">
		<g:message code="shiroUser.passwordHash.label" default="Password Hash" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="passwordHash" maxlength="30" required="" value="${shiroUserInstance?.passwordHash}"/>
</div>


<div class="fieldcontain ${hasErrors(bean: shiroUserInstance, field: 'email', 'error')} required">
	<label for="email">
		<g:message code="shiroUser.email.label" default="Email" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="email" name="email" required="" value="${shiroUserInstance?.email}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: shiroUserInstance, field: 'borrower', 'error')} ">
	<label for="borrower">
		<g:message code="shiroUser.borrower.label" default="Borrower" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${shiroUserInstance?.borrower?}" var="b">
    <li><g:link controller="borrow" action="show" id="${b.id}">${b?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="borrow" action="create" params="['shiroUser.id': shiroUserInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'borrow.label', default: 'Borrow')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: shiroUserInstance, field: 'own', 'error')} ">
	<label for="own">
		<g:message code="shiroUser.own.label" default="Own" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${shiroUserInstance?.own?}" var="o">
    <li><g:link controller="own" action="show" id="${o.id}">${o?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="own" action="create" params="['shiroUser.id': shiroUserInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'own.label', default: 'Own')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: shiroUserInstance, field: 'owner', 'error')} ">
	<label for="owner">
		<g:message code="shiroUser.owner.label" default="Owner" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${shiroUserInstance?.owner?}" var="o">
    <li><g:link controller="borrow" action="show" id="${o.id}">${o?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="borrow" action="create" params="['shiroUser.id': shiroUserInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'borrow.label', default: 'Borrow')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: shiroUserInstance, field: 'permissions', 'error')} ">
	<label for="permissions">
		<g:message code="shiroUser.permissions.label" default="Permissions" />
		
	</label>
	
</div>

<div class="fieldcontain ${hasErrors(bean: shiroUserInstance, field: 'recipient', 'error')} ">
	<label for="recipient">
		<g:message code="shiroUser.recipient.label" default="Recipient" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${shiroUserInstance?.recipient?}" var="r">
    <li><g:link controller="internalMessage" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="internalMessage" action="create" params="['shiroUser.id': shiroUserInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'internalMessage.label', default: 'InternalMessage')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: shiroUserInstance, field: 'roles', 'error')} ">
	<label for="roles">
		<g:message code="shiroUser.roles.label" default="Roles" />
		
	</label>
	<g:select name="roles" from="${phonelibv2.ShiroRole.list()}" multiple="multiple" optionKey="id" size="5" value="${shiroUserInstance?.roles*.id}" class="many-to-many"/>
</div>

<div class="fieldcontain ${hasErrors(bean: shiroUserInstance, field: 'sender', 'error')} ">
	<label for="sender">
		<g:message code="shiroUser.sender.label" default="Sender" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${shiroUserInstance?.sender?}" var="s">
    <li><g:link controller="internalMessage" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="internalMessage" action="create" params="['shiroUser.id': shiroUserInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'internalMessage.label', default: 'InternalMessage')])}</g:link>
</li>
</ul>

</div>

