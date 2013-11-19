
<%@ page import="phonelibv2.Own" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'own.label', default: 'Own')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-own" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-own" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="own.book.label" default="Book" /></th>
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'own.dateCreated.label', default: 'Date Created')}" />
					
						<th><g:message code="own.user.label" default="User" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${ownInstanceList}" status="i" var="ownInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}" <g:createLink action="show" id="${ownInstance.id}" />>					
						<td><g:link action="show" id="${ownInstance.id}">${fieldValue(bean: ownInstance, field: "book")}</g:link></td>
					
						<td><g:formatDate date="${ownInstance.dateCreated}" /></td>
					
						<td>${fieldValue(bean: ownInstance, field: "user")}</td>
						<td id="${ownBookInstanceList[i].isbn13}"></td>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${ownInstance?.id}" />
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
<script type="text/javascript" src="/phonelibV2/js/douban_api.js"></script>
<script>
//alert(${ownBookInstanceList[i].isbn13});
DOUBAN.apikey = 
	DOUBAN.getISBNBook({
	    isbn:${ownInstance.book.isbn13},
	    callback:function(re){
	       eletest=document.getElementById(re.isbn13);
	       eletest.innerHTML=re.title; 
	       // alert(re.title);
	       //eletest.parentNode.appendChild(re.title);
	       //alert(re.isbn13);
	       //eletest=document.getElementById(re.isbn13+"title");
	       //eletest.innerHTML=re.title;
	    }
	})
</script>							
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${ownInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
