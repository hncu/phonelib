<%@ page import="phonelibv2.Category" %>



<div class="fieldcontain ${hasErrors(bean: categoryInstance, field: 'cname', 'error')} required">
	<label for="cname">
		<g:message code="category.cname.label" default="Cname" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="cname" required="" value="${categoryInstance?.cname}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: categoryInstance, field: 'books', 'error')} ">
	<label for="books">
		<g:message code="category.books.label" default="Books" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${categoryInstance?.books?}" var="b">
    <li><g:link controller="book" action="bgshow" id="${b.id}">${b?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="book" action="bgcreate" params="['category.id': categoryInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'book.label', default: 'Book')])}</g:link>
</li>
</ul>

</div>

