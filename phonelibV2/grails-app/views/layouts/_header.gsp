
<div class="navbar navbar-fixed-top">
	<div class="navbar-inner">
		<div class="container">
			<button type="button" class="btn btn-navbar" data-toggle="collapse"
				data-target=".nav-collapse">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="brand" href="http://localhost:8080/phonelibV2/">手机图书馆</a>
			<div class="nav-collapse collapse">
				<ul class="nav">
					<li class="divider-vertical"></li>
					<li class="active"><a href="http://localhost:8080/phonelibV2/">首页</a></li>
					<li class="divider-vertical"></li>
					<li><a href="http://localhost:8080/phonelibV2/book/list">馆藏图书</a></li>
					<li class="divider-vertical"></li>
					<shiro:hasRole name="ROLE_ADMIN">
						<li><a href="http://localhost:8080/phonelibV2/shiroUser/list">用户管理</a></li>
						<li class="divider-vertical"></li>
					</shiro:hasRole>

					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown">个人图书管理 <b class="caret"></b></a>
						<ul class="dropdown-menu">
							<li><a href="http://localhost:8080/phonelibV2/own/list">我的图书</a></li>
							<li><a href="http://localhost:8080/phonelibV2/borrow/list">借出图书</a></li>
							<li><a href="http://localhost:8080/phonelibV2/borrow/list">借入图书</a></li>
						</ul></li>
				</ul>
				<shiro:isLoggedIn>
					<a class="divider-vertical"></a>				
					 你好，<shiro:principal /> ！
					<a href="http://localhost:8080/phonelibV2/auth/signOut">注销</a>					
				</shiro:isLoggedIn>
				<shiro:isNotLoggedIn>      
                	<g:form controller="auth" action="signIn" class="navbar-form pull-right">
						<input class="span2" type="text" name="username" placeholder="邮件">
						<input class="span2" type="password" name="password" placeholder="密码">
						<button type="submit" class="btn">登陆</button>
						<a href="http://localhost:8080/phonelibV2/signup/index">注册</a>
					</g:form>
				</shiro:isNotLoggedIn>
			</div>
			<!--/.nav-collapse -->
		</div>
	</div>
</div>