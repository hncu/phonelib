<%@ page import="phonelibv2.Own" %>



<div class="fieldcontain ${hasErrors(bean: ownInstance, field: 'book', 'error')} required">
	<label for="book">
		<g:message code="own.book.label" default="Book" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="book" name="book.id" from="${phonelibv2.Book.list()}" optionKey="id" required="" value="${ownInstance?.book?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: ownInstance, field: 'user', 'error')} required">
	<label for="user">
		<g:message code="own.user.label" default="User" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="user" name="user.id" from="${phonelibv2.ShiroUser.list()}" optionKey="id" required="" value="${ownInstance?.user?.id}" class="many-to-one"/>
</div>

