
<%@ page import="phonelibv2.Borrow" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'borrow.label', default: 'Borrow')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
			<script type="text/javascript" src="/phonelibV2/js/douban_api.js"></script>
	</head>
	<body>
	
	<div id="list-own" class="content scaffold-list" role="main">
			
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			
				
				<div>
			<div class="span3">
				<ul >
        					<li class="nav-header"><h3>图书类别</h3></li>
        					
							<!-- 分类加载-->
							<li class="categpry">
							 <g:link  url="/phonelibV2/">全部</g:link>
							 </li>
								<g:each in="${categoryInstanceList}" status="i" var="categoryInstance">
									<div >
										<li class="categpry">
											<g:link controller="book"  action="category" id="${categoryInstance.id}">${categoryInstance.cname}</g:link>
										</li>
										
									</div>
								</g:each>
						</ul>
			</div>
			
			<!-- end book category -->
			
			<div class="span9">
			
				<div >
				<g:link  action="create">创建新书</g:link>  
				<g:form class="form-search" action="search">  
					<g:textField name="bookName"/>  <g:submitButton  type="submit" name="搜索" class="btn"/>
				</g:form>
				
		<!-- book list -->
				<h1>我的图书</h1>
			
			
			</div>
			
			<div id="list-book" class="content scaffold-list" role="main">
				<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
				</g:if>
			
			
				
				<ul class="thumbnails">
				
				<g:each in="${borrowInstanceList}" status="i" var="borrowInstance">
					
					<li style="margin:10px 7px 5px 7px;" >
					<a class="thumbnail" data-toggle="modal" data-target="#myModal${fieldValue(bean: borrowInstance, field: "book.isbn13")}" href="javascript:" >	
						<div id=${fieldValue(bean: borrowInstance, field: "book.isbn13")}.img></div>
						 <div class="caption" id=${fieldValue(bean: borrowInstance, field: "book.isbn13")}.title></div>
						 
					</a>
					
					<div class="modal hide fade" id="myModal${fieldValue(bean: borrowInstance, field: "book.isbn13")}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					  <div class="modal-dialog">
					    <div class="modal-content">
					      <div class="modal-header">
					        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					        <h4 class="modal-title" id="myModalLabel"><div id="${fieldValue(bean: borrowInstance, field: "book.isbn13")}.title.dialog"></div></h4>
					      </div>
					      <div class="modal-body">
					     	 <div class="row-fluid">
					     	   <div class="span3">
						       	<div id=${fieldValue(bean: borrowInstance, field: "book.isbn13")}.img.dialog></div>
						       </div>
						       	<div class="span9" >
						       		创建时间:<g:formatDate date="${borrowInstance.dateCreated}" /><br/>
				<!-- 问题 -->
						       		分类：${fieldValue(bean: categoryInstanceList, field: "cname")}<br/>
						       		isbn:${fieldValue(bean: borrowInstance, field: "book.isbn13")}
							       	<div id=${fieldValue(bean: borrowInstance, field: "book.isbn13")}.author.dialog></div>
							       	<div id=${fieldValue(bean: borrowInstance, field: "book.isbn13")}.publisher.dialog></div>
							       	<div id=${fieldValue(bean: borrowInstance, field: "book.isbn13")}.pubdate.dialog></div>
						       	</div>
						      </div>
						      <div class="span12">
						      	<h5 style="color: #888888;">--内容简介--</h5>
						      	<div id=${fieldValue(bean: borrowInstance, field: "book.isbn13")}.summary> </div>
						      </div>
						  </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					        <button type="button" class="btn btn-primary">Save changes</button>
					      </div>
					    </div><!-- /.modal-content -->
					  </div><!-- /.modal-dialog -->
					</div><!-- /.modal -->
					</li>
					
					<script type="text/javascript">
					DOUBAN.apikey = 
						DOUBAN.getISBNBook({
						    isbn:${fieldValue(bean: borrowInstance, field: "book.isbn13")},
						    callback:function(re){
						        //alert(re.title);
						        var Title=re.title;
						        var bookTitle=re.title;
						        var len=Title.length;
						        if(len>6){
						        	var bookTitle = Title.slice(0, 5);
							        }
						       document.getElementById(re.isbn13+'.title').innerHTML=bookTitle; 
						       document.getElementById(re.isbn13+'.img').innerHTML="<img style=\"height:160px; width:120px;\" src="+re.images.medium+">";
						       document.getElementById(re.isbn13+'.title.dialog').innerHTML=Title;
						       document.getElementById(re.isbn13+'.img.dialog').innerHTML="<img style=\"height:160px; width:120px;\" src="+re.images.medium+">";
						       document.getElementById(re.isbn13+'.author.dialog').innerHTML='作者：'+re.author;
						       document.getElementById(re.isbn13+'.publisher.dialog').innerHTML='出版社：'+re.publisher;
						       document.getElementById(re.isbn13+'.pubdate.dialog').innerHTML='出版时间：'+re.pubdate;
						       document.getElementById(re.isbn13+'.summary').innerHTML=re.summary;
						    }
						})
					</script>
					
				</g:each>
			</ul>
			<!-- end booklist -->
				<div class="pagination">
					<g:paginate total="${borrowInstanceTotal}" />
				</div>
			</div>
			</div>
				
			
		</div>
				
			
		</div>
		
		
	
	
	
	
		<a href="#list-borrow" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-borrow" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="borrow.book.label" default="Book" /></th>
					
						<th><g:message code="borrow.borrower.label" default="Borrower" /></th>
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'borrow.dateCreated.label', default: 'Date Created')}" />
					
						<th><g:message code="borrow.owner.label" default="Owner" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${borrowInstanceList}" status="i" var="borrowInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${borrowInstance.id}">${fieldValue(bean: borrowInstance, field: "book")}</g:link></td>
					
						<td>${fieldValue(bean: borrowInstance, field: "borrower")}</td>
					
						<td><g:formatDate date="${borrowInstance.dateCreated}" /></td>
					
						<td>${fieldValue(bean: borrowInstance, field: "owner")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${borrowInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
