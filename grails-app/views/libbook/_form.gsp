<%@ page import="phonelibv2.Libbook" %>



<div class="fieldcontain ${hasErrors(bean: libbookInstance, field: 'isbn', 'error')} ">
	<label for="isbn">
		<g:message code="libbook.isbn.label" default="Isbn" />
		
	</label>
	<g:textField name="isbn" value="${libbookInstance?.isbn}"/>
</div>

