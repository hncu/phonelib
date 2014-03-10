
<%@ page import="phonelibv2.Book"%>
<!doctype html>

<html>
<head>
<meta name="layout" content="main">
<g:set var="entityName"
	value="${message(code: 'book.label', default: 'Book')}" />
<title>
<g:message code="default.list.label" args="[entityName]" /></title>

	<link rel="stylesheet" type="text/css" href="/phonelibV2/js/own/main.css" />
	<link rel="stylesheet" type="text/css" href="/phonelibV2/js/own/tag.css" />
	<link rel="stylesheet" type="text/css" href="/phonelibV2/js/own/jquery.qtip.css" />
	<link rel="stylesheet" type="text/css" href="/phonelibV2/js/own/setting.css" />
	

</head>
<body>
<script type="text/javascript" src="/phonelibV2/js/douban_api.js"></script>
<script type="text/javascript" src="/phonelibV2/js/own/jquery.simplemodal.js"></script> 
<script type="text/javascript" src="/phonelibV2/js/own/jquery.qtip.js"></script> 
<script type="text/javascript" src="/phonelibV2/js/own/jquery.floatdiv.js"></script>
<script type="text/javascript" src="/phonelibV2/js/own/jquery.form.js"></script>
<script type="text/javascript" src="/phonelibV2/js/own/web.js"></script>
<script type="text/javascript" src="/phonelibV2/js/own/setting.js"></script>




<div id="middleBooks" style='margin-top:50px;'>
	<h3>创建一本书</h3>
	<span style='color:#666666'>感谢您让晒书派多认识一本书！把你的图书加入到你的书屋，与小伙伴们分享吧!</span>
	<br/><br/><br/>
	
		
	<!-- form id="upForm" action="/index.php/setting/preuploadbook" method = "get"-->
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${ownInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${ownInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
	
	<g:form method="post" action="save">
		<table>
			<tr class='tbTr'>
				<td class='tbTitle'>
					<span class='textTitle'>书名</span>
				</td>
				<td>
					<input type='text' name='book_name' id='book_name' class='uploadinfo' value=''/>
				</td>
				<td>
				<span class="red">&emsp;*</span>
				</td>
			</tr>
			<tr class='tbTr'>
				<td class='tbTitle'>
					<span class='textTitle'>ISBN</span>
				</td>
				<td>
					<input type='text' name='isbn' id='isbn' class='uploadinfo' value=''/>
				</td>
				<td>
					<span id='notice' class='notice'></span>
				</td>
			</tr>
			<tr class='tbTr'>
				<td class='tbTitle'>
					<span  class='textTitle'>类别</span>
				</td>
				<td>
					<g:select  id="category" name="category.id" from="${phonelibv2.Category.list()}" optionKey="cname" required="" value="${categoryInstance?.category?.id}" class="uploadinfo"/>
				</td>
			</tr>

	    </table>
			<br/><br/>
			<g:submitButton name="create" class='blueBtn' value="创建这本书"></g:submitButton>
			<g:submitButton  value='取消创建' class='greyBtn' name='preRstBtn2'></g:submitButton>
	  </g:form>
	    <br/>
	    <input type='hidden' value='29688' name='uid' id='uid'/>
	    
		<input type='hidden' value='/index.php' id='url'/>
		<div  id='middle_title'><h3>请单击选择你要添加的书:</h3></div>
		<div id='middleBooks' style='margin-left:-35px;min-height:100px'>
			<ul id="booksList">
			
			</ul>
			<ul id="radioList">
			
			</ul>

		</div>
		
</div>
</body>
</html>
