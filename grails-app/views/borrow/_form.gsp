<%@ page import="phonelibv2.Borrow" %>



<div class="fieldcontain ${hasErrors(bean: borrowInstance, field: 'book', 'error')} required">
	<label for="book">
		<g:message code="borrow.book.label" default="Book" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="book" name="book.id" from="${phonelibv2.Book.list()}" optionKey="id" required="" value="${borrowInstance?.book?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: borrowInstance, field: 'borrower', 'error')} required">
	<label for="borrower">
		<g:message code="borrow.borrower.label" default="Borrower" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="borrower" name="borrower.id" from="${phonelibv2.ShiroUser.list()}" optionKey="id" required="" value="${borrowInstance?.borrower?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: borrowInstance, field: 'owner', 'error')} required">
	<label for="owner">
		<g:message code="borrow.owner.label" default="Owner" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="owner" name="owner.id" from="${phonelibv2.ShiroUser.list()}" optionKey="id" required="" value="${borrowInstance?.owner?.id}" class="many-to-one"/>
</div>

