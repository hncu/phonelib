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
		      <g:if test="${flash.message}">
    				<div class="message" style="color: red">${flash.message}</div>
  				</g:if>
		      <div class="all-errors"> </div>
		      <div class="input-prepend">
		       <span class="add-on"><i class="icon-envelope"></i></span>
		        <input id="username" type="text" value="${username}" placeholder="邮件/手机" name="username" maxlength="75" class="span11" />
		        <div class="email_suggestion"></div>
		      </div>
		      <div class="input-prepend">
		      <span class="add-on"><i class="icon-italic"></i></span>
		        <input type="password"  placeholder="密码" name="password" id="password" class="span11" />
		      </div>
		      <div class="action">
		        <label class="checkbox">
		          <td>记住我</td>
          			<td><g:checkBox name="rememberMe" value="${rememberMe}" /></td>
          		</label>
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
