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
	<g:select id="recipient" name="recipient.id" from="${phonelibv2.ShiroUser.list()}" optionKey="id" required="" value="${internalMessageInstance?.recipient?.id}" class="many-to-one"/>
</div>



