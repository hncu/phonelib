
<%@ page import="phonelibv2.Book"%>
<!doctype html>

<html>
<head>
<meta name="layout" content="main">
<g:set var="entityName"
	value="${message(code: 'book.label', default: 'Book')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>

<script type="text/javascript" src="/phonelibV2/js/douban_api.js"></script>


</head>
<body>

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


	<div>
		<div class="span3">
			<ul class="well sidebar-nav">
				<li class="nav-header"><h3>图书类别</h3></li>

				<!-- 分类加载-->
				<g:link url="/phonelibV2/own/list">全部</g:link>

				<g:each in="${ownInstanceList.book.category}" status="i"
					var="categoryInstance">

					<li class="nav" style="list-style-type: none"><g:link
							controller="own" action="category" id="${categoryInstance.id}">
							${categoryInstance.cname}
						</g:link></li>

				</g:each>
			</ul>
		</div>

		<div class="span9">
			<g:link action="create">创建新书</g:link>
			<g:form class="form-search" action="search">
				<g:textField name="bookName" />
				<g:submitButton type="submit" name="搜索" class="btn" />
			</g:form>

			<div id="list-book" class="content scaffold-list" role="main">
				<h1>图书列表</h1>
				<g:if test="${flash.message}">
					<div class="message" role="status">
						${flash.message}
					</div>
				</g:if>


				<ul class="thumbnails">

					<g:each in="${ownInstanceList}" status="i" var="ownInstance">

						<li style="margin: 10px 7px 5px 7px;"><a class="thumbnail"
							data-toggle="modal" data-target="#myModal${ownInstance.book.isbn13}"
							href="javascript:">
								<div id=${ownInstance.book.isbn13}.img></div>
								<div class="caption" id=${ownInstance.book.isbn13}.title></div>

						</a>

							<div class="modal hide fade" id="myModal${ownInstance.book.isbn13}"
								tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
								aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal"
												aria-hidden="true">&times;</button>
											<h4 class="modal-title" id="myModalLabel">
												<div id="${ownInstance.book.isbn13}.title.dialog"></div>
											</h4>
										</div>
										<div class="modal-body">
											<div class="row-fluid">
												<div class="span3">
													<div id=${ownInstance.book.isbn13}.img.dialog></div>
												</div>
												<div class="span9">
													分类：
													<div id=${ownInstance.book.isbn13}.x.dialog></div>
													isbn:${ownInstance.book.isbn13}
													<div id=${ownInstance.book.isbn13}.author.dialog></div>
													<div id=${ownInstance.book.isbn13}.publisher.dialog></div>
													<div id=${ownInstance.book.isbn13}.pubdate.dialog></div>
												</div>
											</div>
											<div class="span12">
												<h5 style="color: #888888;">--内容简介--</h5>
												<div id=${ownInstance.book.isbn13}.summary></div>
											</div>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-default"
												data-dismiss="modal">关闭</button>
											<button type="button" class="btn btn-primary">Save
												changes</button>
										</div>
									</div>
									<!-- /.modal-content -->
								</div>
								<!-- /.modal-dialog -->
							</div> <!-- /.modal --></li>

						<script type="text/javascript">
					DOUBAN.apikey = 
						DOUBAN.getISBNBook({
						    isbn:${ownInstance.book.isbn13},
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

				<div class="pagination">
					<g:paginate total="2" />
				</div>
			</div>
		</div>

		<div class="span3">dfaasdf</div>
	</div>
</body>
</html>
