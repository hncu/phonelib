
<%@ page import="phonelibv2.Libbook" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<script type="text/javascript" src="/phonelibV2/js/douban_api.js"></script>
		<title>湖南城市学院图书馆查询</title>
	</head>
	<body>
		<a href="#list-libbook" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
	<g:form class="form-search" action="search">
		<div class="input-group input-group-lg">
			<input type="text" name="bookName" class="form-control"
				placeholder="书名、ISBN">
			<g:submitButton type="submit" name="搜索" class="btn" />
		</div>
	</g:form>

	<div id="list-libbook" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="isbn" title="${message(code: 'libbook.isbn.label', default: 'Isbn')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${libbookInstanceList}" status="i" var="libbookInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${libbookInstance.id}">${libbookInstance.isbn13 }</g:link></td>
					
					</tr>
				</g:each>
				
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${libbookInstanceTotal}" />
			</div>
		</div>
		<hr/>
		<g:each in="${libbookInstanceList}" status="i" var="libbookInstance">
		<script type="text/javascript">
		
					DOUBAN.apikey = 
						DOUBAN.getISBNBook({
						    isbn:${libbookInstance.isbn13},
						    callback:function(re){
						        //alert(re.title);
						        var Title=re.title;
						        var bookTitle=re.title;
								alert(Title);
								
	
						    }
						})
						
					</script>
		</g:each>
	</body>
</html>
