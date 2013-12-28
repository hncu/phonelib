<!doctype html>
<html lang="zh-CN">
	<head>
		<meta name="layout" content="main_index"/>
		<meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- 禁用其缩放 -->
		<link href="/phonelibV2/css/bootstrap.css" type="text/css" media="screen">
		<link href="/phonelibV2/css/bootstrap.min.css" type="text/css" media="screen">
		<link href="/phonelibV2/css/bootstrap-theme.css" type="text/css" media="screen">
		<link href="/phonelibV2/css/bootstrap-theme.min.css" type="text/css" media="screen">
		<link href="/phonelibV2/css/bootstrap-responsive.css" type="text/css" media="screen">
		
		<title>晒书派 | 与书友分享你的书籍</title>
		<style type="text/css" media="screen">
			#status {
				background-color: #eee;
				border: .2em solid #fff;
				margin: 2em 2em 1em;
				padding: 1em;
				width: 12em;
				float: left;
				-moz-box-shadow: 0px 0px 1.25em #ccc;
				-webkit-box-shadow: 0px 0px 1.25em #ccc;
				box-shadow: 0px 0px 1.25em #ccc;
				-moz-border-radius: 0.6em;
				-webkit-border-radius: 0.6em;
				border-radius: 0.6em;
			}

			.ie6 #status {
				display: inline; /* float double margin fix http://www.positioniseverything.net/explorer/doubled-margin.html */
			}

			#status ul {
				font-size: 0.9em;
				list-style-type: none;
				margin-bottom: 0.6em;
				padding: 0;
			}
            
			#status li {
				line-height: 1.3;
			}

			#status h1 {
				text-transform: uppercase;
				font-size: 1.1em;
				margin: 0 0 0.3em;
			}

			#page-body {
				margin: 2em 1em 1.25em 18em;
			}

			h2 {
				margin-top: 1em;
				margin-bottom: 0.3em;
				font-size: 1em;
			}

			p {
				line-height: 1.5;
				margin: 0.25em 0;
			}

			#controller-list ul {
				list-style-position: inside;
			}

			#controller-list li {
				line-height: 1.3;
				list-style-position: inside;
				margin: 0.25em 0;
			}

			@media screen and (max-width: 480px) {
				#status {
					display: none;
				}

				#page-body {
					margin: 0 1em 1em;
				}

				#page-body h1 {
					margin-top: 0;
				}
			}
		</style>
	</head>
	<body>
		<!-- <a href="#page-body" class="skip"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a> -->
			
			
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
						<li class="active"><a href="/phonelibV2/">首页</a></li>
					</shiro:isNotLoggedIn>
					<shiro:isLoggedIn>
						<li class="active"><a href="/phonelibV2/book/list">首页</a></li>
					</shiro:isLoggedIn>
					<li class="divider-vertical"></li>
					<li ><a href="/phonelibV2/book/list">馆藏图书</a></li>
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
                    <li class="dropdown">
		<a class="dropdown-toggle"  href="#">
          <i class="icon-envelope"></i> 站内信
          <span class="badge badge-info msg_num hide"></span></a></li>
		<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#"><shiro:principal /><b class="caret"></b> </a>
		<ul class="dropdown-menu">
		<li > <a href="#"> <i class="icon-cog"></i> 个人设置 </a> </li>
		
		
		<li class="divider">&nbsp;</li>
		<li><a href="/phonelibV2/auth/signOut"><i class="icon-off"></i>  退出</a></li>
	</ul></li>
                  </ul>
                  
								
					 
										
				</shiro:isLoggedIn>
				<shiro:isNotLoggedIn>              
						
						<ul class="nav pull-right">
                    <li><a href="/phonelibV2/signup/index">注册</a></li>
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
				
					
		
			<div class="hero-unit">
			  
		        <div align="center">
		  
		          <h1>
		      		      与书友分享你的书籍
		          </h1>
		          <br>
		          
		       	  <p>还没有账号?现在加入 <a href="/phonelibV2/signup/index" class="btn btn-primary btn-large">立即注册</a></p>
		        </div>
		      <hr>
		    <div class="row-fluid">
		       <div class="span7">
		      
			<div class="carousel slide" id="carousel-561177">
			<ol class="carousel-indicators">
			<li class="active" data-slide-to="0">&nbsp;</li>
			<li data-slide-to="1">&nbsp;</li>
		</ol>
		
		<div class="carousel-inner">
		      
		<div class="item active"><img alt="" src="/phonelibV2/images/lib1.jpg" width="100%"/>
		<div class="carousel-caption">
		<p>hncu</p>
		</div>
		</div>
		
		<div class="item"><img alt="" src="/phonelibV2/images/lib2.jpg" width="100%"/>
		<div class="carousel-caption">
		<p>hncu</p>
		</div>
		</div>
		
		
		
	
		
		
		</div>
		<a class="left carousel-control" data-slide="prev" href="#carousel-561177">&lsaquo;</a> <a class="right carousel-control" data-slide="next" href="#carousel-561177">&rsaquo;</a></div>
		
		           </div>
		      <div class="span4">
		        <div class="well">
		      <form action="/phonelibV2/auth/signIn" id="myform" method="POST">
		      <h5>用户登录</h5> 
		      <div class="all-errors"> </div>
		      <div class="input-prepend">
		       <span class="add-on"><i class="icon-envelope"></i></span>
		        <input id="username" type="text" placeholder="邮件/手机" name="username" maxlength="75" class="span11" />
		        <div class="email_suggestion"></div>
		      </div>
		      <div class="input-prepend">
		      <span class="add-on"><i class="icon-key"></i></span>
		        <input type="password" placeholder="密码" name="password" id="password" class="span11" />
		      </div>
		      <div class="action">
		        <label class="checkbox">
		          <input type="checkbox" name="info[remember]" value="1">
		          记住密码 </label>
		           <input type="hidden" name="dosubmit" value="1" />
		        <input type="submit" value="登录" class="btn btn-green"/>
		    <span style="margin-left:15px"><a href="#"><small>找回密码</small></a></span>
		      </div>
		      
		      
		    </form>
		
		         </div>
		         </div>
		    </div>
		
		          
		</div>
			
			
	
	</body>
</html>
