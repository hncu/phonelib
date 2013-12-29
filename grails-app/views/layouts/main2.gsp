<!--  更改用户个人信息的main -->
<!doctype html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title><g:layoutTitle default="Grails" /></title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="shortcut icon"
	href="${resource(dir: 'images', file: 'favicon.ico')}"
	type="image/x-icon">
<link rel="apple-touch-icon"
	href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
<link rel="apple-touch-icon" sizes="114x114"
	href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
<r:require modules="bootstrap" />
<style type="text/css">
body {
	padding-top: 60px;
	padding-bottom: 40px;
}
</style>
<g:layoutHead />
<r:layoutResources />



</head>
<body onload="YearMonthDay()">


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
								<li><a href="/phonelibV2/borrow/ownerlist">借出图书</a></li>
								<li><a href="/phonelibV2/borrow/borrowerlist">借入图书</a></li>
							</ul></li>
					</ul>
					<shiro:isLoggedIn>

						<ul class="nav pull-right">
							<li class="dropdown"><a class="dropdown-toggle"
								href="/phonelibV2/InternalMessage/list"> <i
									class="icon-envelope"></i> 站内信 <span
									class="badge badge-info msg_num hide">32</span></a></li>
							<li class="dropdown"><a class="dropdown-toggle"
								data-toggle="dropdown" href="#"><shiro:principal /><b
									class="caret"></b> </a>
								<ul class="dropdown-menu">
									<li><a href="/phonelibV2/signup/accout/1"> <i
											class="icon-cog"></i> 个人设置
									</a></li>


									<li class="divider">&nbsp;</li>
									<li><a href="/phonelibV2/auth/signOut"><i
											class="icon-off"></i> 退出</a></li>
								</ul></li>
						</ul>

					</shiro:isLoggedIn>
					<shiro:isNotLoggedIn>

						<ul class="nav pull-right">
							<li><a href="/phonelibV2/signup">注册</a></li>
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



	<!-- div id="grailsLogo" role="banner"><a href="http://grails.org"><img src="${resource(dir: 'images', file: 'grails_logo.png')}" alt="Grails"/></a></div> -->
	<div class="container">
		<div class="row-fluid">
			<div class="span1"></div>
			<div class="span5">
				<g:layoutBody />
			</div>
		</div>
	</div>

	<g:render template="/layouts/footer" />
	<!--<div class="footer" role="contentinfo"></div>
		<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>-->
	<g:javascript library="application" />
	<r:layoutResources />
</body>
</html>