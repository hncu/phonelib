
<%@ page import="phonelibv2.InternalMessage" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'internalMessage.label', default: 'InternalMessage')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-internalMessage" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-internalMessage" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			
	
			
			
			 <table class="table">
        <thead>
          <tr>
            <th class="span2">发信人</th>
            <th class="span6">内容</th>
            <th class="span2">沟通状态</th>
            <th class="span2">操作</th>
          </tr>
        </thead>
        
        <tbody>
        <g:each in="${internalMessageInstanceList}" status="i" var="internalMessageInstance">
                    <tr class="message_list">
                    
            <td>
	    <img src="http://tp1.sinaimg.cn/2536625632/50/40004201173/1" class="img-circle" style="width: 50px;"><br>
            ${fieldValue(bean: internalMessageInstance, field: "sender.username")}
             </td>
            <td><g:link action="show" id="${internalMessageInstance.id}">  ${fieldValue(bean: internalMessageInstance, field: "message")}  <g:if test="${internalMessageInstance.statue}">  <span class="badge badge-info">未读</span></g:if></a>
                           </g:link><br />
              <small>${fieldValue(bean: internalMessageInstance, field: "dateCreated")}</small></td>
            <td><small><font color="green">.....</font></small>
	      <br>
              <span id="have_judge_26453" class="label label-success hide">已评价</span>
	      <a  id="need_judge_26453" data-toggle="modal" href="#commentModal" class="btn btn-small " onclick="javascript:set_comments(26453,'囙憶-蕞羙',1)">评价</a>
            </td>
            <td><a data-toggle="modal" href="#tousuModal" onclick="javascript:set_jubao(26453,'囙憶-蕞羙')"><small>....</small></a><br>
                            <a href="http://www.ycpai.com/active/cancle_message/26453"><small>....</small></a>
              </td>
          </tr>
                  </g:each>
                  </tbody>
      </table>
			
			
			
			
			
			
			
			
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'internalMessage.dateCreated.label', default: 'Date Created')}" />
					
						<g:sortableColumn property="message" title="${message(code: 'internalMessage.message.label', default: 'Message')}" />
					
						<th><g:message code="internalMessage.recipient.label" default="Recipient" /></th>
					
						<th><g:message code="internalMessage.sender.label" default="Sender" /></th>
					
						<g:sortableColumn property="statue" title="${message(code: 'internalMessage.statue.label', default: 'Statue')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${internalMessageInstanceList}" status="i" var="internalMessageInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${internalMessageInstance.id}">${fieldValue(bean: internalMessageInstance, field: "dateCreated")}</g:link></td>
					
						<td>${fieldValue(bean: internalMessageInstance, field: "message")}</td>
					
						<td>${fieldValue(bean: internalMessageInstance, field: "recipient")}</td>
					
						<td>${fieldValue(bean: internalMessageInstance, field: "sender")}</td>
					
						<td><g:formatBoolean boolean="${internalMessageInstance.statue}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${internalMessageInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
