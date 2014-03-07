<!doctype html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title><g:layoutTitle default="Grails"/></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
		<link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
		<link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
		<r:require modules="bootstrap"/>
		<style type="text/css">
	      body {
	        padding-top: 60px;
	        padding-bottom: 40px;
	      }
	    </style>
		<g:layoutHead/>
        <r:layoutResources />
	</head>
	<body>	
		<g:render template="/layouts/header"/>
		<!-- div id="grailsLogo" role="banner"><a href="http://grails.org"><img src="${resource(dir: 'images', file: 'grails_logo.png')}" alt="Grails"/></a></div> -->
		<div class="container">
				<div class="row-fluid" >
					<div class="span10"><g:layoutBody/></div>
					<div id="span2" class="span2">
					<shiro:isNotLoggedIn>
					<h2>为了更好地体验，请登录</h2>
					</shiro:isNotLoggedIn>
					<shiro:isLoggedIn>
						<div class="well sidebar-nav" >
					<g:link controller="signup" action="tx"><img src="${resource(dir: 'images', file: "${shiroUserInstance}")}"> </g:link>
						<shiro:principal />
						<br/>
						益阳 赫山区 
						<br/>
						动态同步
						<br/>
						我的图书
						<br/>
						<br/>
						借出图书
						<br/>
						<br/>
						借入图书
						<br/>
						<br/>
						应用下载
						<a href="#"><img src="http://shaishufang.com/assets/android.png"/></a>
						关注我们
						<a href="#"><img src="http://shaishufang.com/assets/flowerkai.png"/></a>
						
						</div>
						</shiro:isLoggedIn>
					</div>
				</div>
				
			<g:render template="/layouts/footer"/>
		</div>
		<!--<div class="footer" role="contentinfo"></div>
		<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>-->
		<g:javascript library="application"/>
        <r:layoutResources />
	</body>
</html>