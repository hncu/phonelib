<%@ page import="phonelibv2.InternalMessage" %>



<div class="fieldcontain ${hasErrors(bean: internalMessageInstance, field: 'message', 'error')} ">
	<label for="message">
		<g:message code="internalMessage.message.label" default="Message" />
		
	</label>
	<g:textField name="message" value="${internalMessageInstance?.message}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: internalMessageInstance, field: 'recipient', 'error')} required">
	<label for="recipient">
		<g:message code="internalMessage.recipient.label" default="Recipient" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="recipient" name="recipient.id" from="${phonelibv2.ShiroUser.list()}" optionKey="id" optionValue="username" required="" value="${internalMessageInstance?.recipient?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: internalMessageInstance, field: 'sender', 'error')} required">
	<label for="sender">
		<g:message code="internalMessage.sender.label" default="Sender" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="sender" name="sender.id" from="${phonelibv2.ShiroUser.list()}" optionKey="id" optionValue="username" required="" value="${internalMessageInstance?.sender?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: internalMessageInstance, field: 'statue', 'error')} ">
	<label for="statue">
		<g:message code="internalMessage.statue.label" default="Statue" />
		
	</label>
	<g:checkBox name="statue" value="${internalMessageInstance?.statue}" />
</div>

