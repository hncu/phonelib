<%@ page import="phonelibv2.ShiroUser" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main1">
		<g:set var="entityName" value="${message(code: 'shiroUser.label', default: 'ShiroUser')}" />
		<title>欢迎加入我们</title>
	</head>
	<body>

	 
	 
	 
		<div id="create-shiroUser" class="content scaffold-create" role="main">
			<br/>
			<h1><font face="黑体">欢迎加入我们</font></h1>
			<br/>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${shiroUserInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${shiroUserInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form action="register" >
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
				<br/>
					<input type="submit" value="注册" class="btn" />
					
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
