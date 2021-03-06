
<%@ page import="phonelibv2.Borrow" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'borrow.label', default: 'Borrow')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
			<script type="text/javascript" src="/phonelibV2/js/douban_api.js"></script>
			<style type="text/css">
.category {
	font-size: 14px;
	line-height: 40px;
	list-style-type: none;
	background: #EEEEEE;
	font-size: 14px;
	height: 38px;
	line-height: 40px;
	margin-left: 6px;
	margin-top: 1px;
	text-indent: 36px;
	width: 140px;
}
.prevLink{
padding: 2px 5px;
border-width: 1px;
border-style: solid;
border-color: rgb(238, 238, 238);
margin: 2px;
color: rgb(3, 108, 180);
text-decoration: none;
}
.currentStep{
padding: 2px 5px;
border-width: 1px;
border-style: solid;
border-color: rgb(3, 108, 180);
font-weight: bold;
margin: 2px;
color: rgb(255, 255, 255);
background-color: rgb(3, 108, 180);
}
.nextLink{
padding: 2px 5px;
border-width: 1px;
border-style: solid;
border-color: rgb(238, 238, 238);
margin: 2px;
color: rgb(3, 108, 180);
text-decoration: none;
}
.step{
padding: 2px 5px;
border-width: 1px;
border-style: solid;
border-color: rgb(238, 238, 238);
margin: 2px;
color: rgb(3, 108, 180);
text-decoration: none;
}
</style>
	</head>
	<body>
	
	<div id="list-own" class="content scaffold-list" role="main">
			
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			
				
				<div>
			<div class="span3">
				<ul>
				<li class="nav-header"><h3>图书类别</h3></li>
				<!-- 分类加载-->
				<g:if test="${params.id==null }"><li class="category" style="background-image:url(/phonelibV2/images/category_action.jpg);width: 160px;"></g:if>
				<g:else><li class="category"></g:else>
					<g:link url="/phonelibV2/book/list">全部</g:link>
				</li>
				<g:each in="${categoryInstanceList}" status="i"
					var="categoryInstance">
					<div >
						<g:if test="${(""+categoryInstance.id)==params.id}"><li class="category" style="background-image:url(/phonelibV2/images/category_action.jpg);width: 160px;"></g:if>
						<g:else><li class="category"></g:else>
							<g:link controller="book"
								action="list" id="${categoryInstance.id}">
								${categoryInstance.cname}
							</g:link></li>
					</div>
				</g:each>
			</ul>
			</div>
			
			<!-- end book category -->
			
			<div class="span9">
			
				<div >
	
		<!-- book list -->
		<g:if test="${params.action=="ownerlist"}">
				<span class="nav-header"><h2>借出图书</h2></span>
			</g:if><g:else>
				<span class="nav-header"><h2>借入图书</h2></span>
			</g:else>
			
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
					        <g:if test="${!borrowInstance?.borrowerAck} ">
					        	<g:link controller="internalMessage" action="backAck" params="[borrowId:borrowInstance.id]">确认归还</g:link>
					        </g:if>
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
		

			
			<div class="pagination">
				<g:paginate total="${borrowInstanceTotal}" />
			</div>
		
	</body>
</html>
