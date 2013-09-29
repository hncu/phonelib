
<%@ page import="phonelibv2.Book" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'book.label', default: 'Book')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
		
			<style type="text/css" media="screen">
				#booksList li {
					width: 110px;
					float: left;
				}
			</style>
	</head>
	<body>
		<a href="#list-book" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-book" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
				<div>
					<ul id="booksList">
						<g:each in="${bookInstanceList}" status="i" var="bookInstance">
							<li>
								<a id=${bookInstance.isbn13} href="<g:createLink action="show" id="${bookInstance.id}"/>"></a>
								<br/>
								<a id=${bookInstance.isbn13}title></a>
							</li>
<script type="text/javascript" src="/phonelibV2/js/douban_api.js"></script>
<script>
//alert(${bookInstance.isbn13});
DOUBAN.apikey = 
	DOUBAN.getISBNBook({
	    isbn:${bookInstance.isbn13},
	    callback:function(re){
	       eletest=document.getElementById(re.isbn13);
	       eletest.innerHTML='<img src="'+re.images.medium+'"></img>'; 
	       // alert(re.title);
	       //eletest.parentNode.appendChild(re.title);
	       //alert(re.isbn13);
	       eletest=document.getElementById(re.isbn13+"title");
	       eletest.innerHTML=re.title;
	    }
	})
</script>							
						</g:each>
					</ul>
				</div>	
			<div class="pagination">
				<g:paginate total="${bookInstanceTotal}" />
			</div>
		</div>
	</body>
</html>