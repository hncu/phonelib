<%@ page import="phonelibv2.Book" %>



<div class="fieldcontain ${hasErrors(bean: bookInstance, field: 'title', 'error')} required">
	<label for="title">
		<g:message code="book.title.label" default="Title" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="title" required="" value="${bookInstance?.title}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: bookInstance, field: 'isbn13', 'error')} required">
	<label for="isbn13">
		<g:message code="book.isbn13.label" default="Isbn13" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="isbn13" required="" value="${bookInstance?.isbn13}"/>
</div>


<div class="fieldcontain ${hasErrors(bean: bookInstance, field: 'borrow', 'error')} ">
	<label for="borrow">
		<g:message code="book.borrow.label" default="Borrow" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${bookInstance?.borrow?}" var="b">
    <li><g:link controller="borrow" action="show" id="${b.id}">${b?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="borrow" action="create" params="['book.id': bookInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'borrow.label', default: 'Borrow')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: bookInstance, field: 'own', 'error')} ">
	<label for="own">
		<g:message code="book.own.label" default="Own" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${bookInstance?.own?}" var="o">
    <li><g:link controller="own" action="show" id="${o.id}">${o?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="own" action="create" params="['book.id': bookInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'own.label', default: 'Own')])}</g:link>
</li>
</ul>

</div>

