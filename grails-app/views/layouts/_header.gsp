<script type="text/javascript">
var t=setTimeout("load()",10)
	function load(){
	$.post("/phonelibV2/internalMessage/unreadMessage",
			 function(data) {
		 		if(data!=0){
			 		document.getElementById('unreadMessage').innerHTML=data+"条未读";
		 		}});
	t=setTimeout("load()",60000)
	}
</script>
<div class="navbar navbar-fixed-top">
	<div class="navbar-inner">
		<div class="container">
			<button type="button" class="btn btn-navbar" data-toggle="collapse"
				data-target=".nav-collapse">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<shiro:isNotLoggedIn>
				<a class="brand" href="/phonelibV2/">手机图书馆</a>
			</shiro:isNotLoggedIn>
			<shiro:isLoggedIn>
							<a class="brand" href="/phonelibV2/own/list">手机图书馆</a>
			</shiro:isLoggedIn>
			<div class="nav-collapse collapse">
				<ul class="nav">
					<li class="divider-vertical"></li>
					<g:if test="${params.controller==null}">
						<li class="active">
					</g:if>
					<g:else><li></g:else>
					<shiro:isNotLoggedIn>
								<a href="/phonelibV2/">首页</a>
								<li class="divider-vertical"></li>
					</shiro:isNotLoggedIn>
						
					
					<g:if test="${params.controller=="book"}">
						<li class="active">
					</g:if>
					<g:else><li></g:else>
					<a href="/phonelibV2/book/list">附近图书</a></li>
					<li class="divider-vertical"></li>
					
					<g:if test="${params.controller=="libbook"}">
						<li class="active">
					</g:if>
					<g:else><li></g:else>
					<a href="/phonelibV2/libbook/list">城院图书馆</a></li>
					<li class="divider-vertical"></li>
					
					<shiro:hasRole name="ROLE_ADMIN">
						<li><a href="/phonelibV2/shiroUser/list">用户管理</a></li>
						<li class="divider-vertical"></li>
					</shiro:hasRole>
				
				<g:if test="${params.controller=="borrow"||params.controller=="own"}">
						<li class="dropdown" style="background-color:rgb(229,229, 229)">
					</g:if>
					<g:else><li class="dropdown"></g:else>
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" >个人图书管理 <b class="caret"></b></a>
						<ul class="dropdown-menu">
							<li><a href="/phonelibV2/own/list">我的图书</a></li>
							<li><a href="/phonelibV2/borrow/ownerlist">借出图书</a></li>
							<li><a href="/phonelibV2/borrow/borrowerlist">借入图书</a></li>
						</ul></li>
				</ul>
				<shiro:isLoggedIn>
				
					 <ul class="nav pull-right">
                <g:if test="${params.controller=="InternalMessage"}">
						<li class="dropdown" style="background-color:rgb(229,229, 229)">
					</g:if>
					<g:else><li class="dropdown"></g:else>
		<a class="dropdown-toggle"  href="/phonelibV2/InternalMessage/list">
          <i class="icon-envelope"></i> 站内信
          <div class="badge badge-info" name = "unreadMessage" id ="unreadMessage"></div></a></li>
		<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#"><shiro:principal /><b class="caret"></b> </a>
		<ul class="dropdown-menu">
		<li > <a href="/phonelibV2/signup/accout"> <i class="icon-cog"></i> 个人设置 </a> </li>
		
		
		<li class="divider">&nbsp;</li>
		<li><a href="/phonelibV2/auth/signOut"><i class="icon-off"></i>  退出</a></li>
	</ul></li>
                  </ul>
                  
								
					 
										
				</shiro:isLoggedIn>
				<shiro:isNotLoggedIn>              
						
						<ul class="nav pull-right">
                    <li><a href="/phonelibV2/signup">注册</a></li>
          <li class="divider-vertical"></li>
          <li class="dropdown"> <a class="dropdown-toggle" href="http://www.ycpai.com/index/login" data-toggle="dropdown">登录 <strong class="caret"></strong></a>
            <div class="dropdown-menu" style="padding: 15px; padding-bottom: 0px;">
              <form action="/phonelibV2/auth/signIn" id="myform" method="POST">
                <input style="margin-bottom: 15px;" type="text" placeholder="邮箱" id="username" name="username">
                <input style="margin-bottom: 15px;" type="password" placeholder="密码" id="password" name="password">
                <input class="btn btn-primary btn-block" type="submit" id="sign-in" value="登录">
              </form>
              	
               <span style="height:10px; width:10px; display:block"></span>
              </div>
          </li>
                  </ul>
						
						
					
				</shiro:isNotLoggedIn>
			</div>
			<!--/.nav-collapse -->
		</div>
	</div>
</div>