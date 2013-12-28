<%@ page import="phonelibv2.Category" %>



<div class="fieldcontain ${hasErrors(bean: categoryInstance, field: 'cname', 'error')} required">
	<label for="cname">
		<g:message code="category.cname.label" default="Cname" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="cname" required="" value="${categoryInstance?.cname}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: categoryInstance, field: 'book', 'error')} ">
	<label for="book">
		<g:message code="category.book.label" default="Book" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${categoryInstance?.book?}" var="b">
    <li><g:link controller="book" action="show" id="${b.id}">${b?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="book" action="create" params="['category.id': categoryInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'book.label', default: 'Book')])}</g:link>
</li>
</ul>

</div>

