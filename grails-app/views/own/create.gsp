
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

	<div class="navbar navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container">
				<button type="button" class="btn btn-navbar" data-toggle="collapse"
					data-target=".nav-collapse">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="brand" href="/phonelibV2/">手机图书馆</a>
				<div class="nav-collapse collapse">
					<ul class="nav">
						<li class="divider-vertical"></li>
						<shiro:isNotLoggedIn>
							<li><a href="/phonelibV2/">首页</a></li>
						</shiro:isNotLoggedIn>
						<shiro:isLoggedIn>
							<li><a href="/phonelibV2/book/list">首页</a></li>
						</shiro:isLoggedIn>
						<li class="divider-vertical"></li>
						<li class="active"><a href="/phonelibV2/book/list">馆藏图书</a></li>
						<li class="divider-vertical"></li>
						<shiro:hasRole name="ROLE_ADMIN">
							<li><a href="/phonelibV2/shiroUser/list">用户管理</a></li>
							<li class="divider-vertical"></li>
						</shiro:hasRole>

						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown">个人图书管理 <b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a href="/phonelibV2/own/list">我的图书</a></li>
								<li><a href="/phonelibV2/borrow/list">借出图书</a></li>
								<li><a href="/phonelibV2/borrow/list">借入图书</a></li>
							</ul></li>
					</ul>
					<shiro:isLoggedIn>

						<ul class="nav pull-right">
							<li class="dropdown"><a class="dropdown-toggle" href="#">
									<i class="icon-envelope"></i> 站内信 <span
									class="badge badge-info msg_num hide"></span>
							</a></li>
							<li class="dropdown"><a class="dropdown-toggle"
								data-toggle="dropdown" href="#"><shiro:principal /><b
									class="caret"></b> </a>
								<ul class="dropdown-menu">
									<li><a href="#"> <i class="icon-cog"></i> 个人设置
									</a></li>


									<li class="divider">&nbsp;</li>
									<li><a href="/phonelibV2/auth/signOut"><i
											class="icon-off"></i> 退出</a></li>
								</ul></li>
						</ul>




					</shiro:isLoggedIn>
					<shiro:isNotLoggedIn>

						<ul class="nav pull-right">
							<li><a href="/phonelibV2/signup/index">注册</a></li>
							<li class="divider-vertical"></li>
							<li class="dropdown"><a class="dropdown-toggle"
								href="http://www.ycpai.com/index/login" data-toggle="dropdown">登录
									<strong class="caret"></strong>
							</a>
								<div class="dropdown-menu"
									style="padding: 15px; padding-bottom: 0px;">
									<form action="/phonelibV2/auth/signIn" id="myform"
										method="POST">
										<input style="margin-bottom: 15px;" type="text"
											placeholder="邮箱" id="username" name="username"> <input
											style="margin-bottom: 15px;" type="password" placeholder="密码"
											id="password" name="password"> <input
											class="btn btn-primary btn-block" type="submit" id="sign-in"
											value="登录">
									</form>

									<span style="height: 10px; width: 10px; display: block"></span>
								</div></li>
						</ul>



					</shiro:isNotLoggedIn>
				</div>
				<!--/.nav-collapse -->
			</div>
		</div>
	</div>


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

	<!--/form-->  
	    <!--input type="file" name="attached_file" id="attached_file" style='display:none' />
	    <input type="submit" name="submitBtn" value="立即上传" style='display:none' -->
	    
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
