<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="layout" content="main_index" />
  <title>Login</title>
</head>
<body>



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
		      <g:form action="signIn" method="POST">
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
		      
		      
		    </g:form>
		
		         </div>
		         </div>
		    </div>
		
		          
		</div>
</body>
</html>
