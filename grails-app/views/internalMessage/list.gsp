
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
			<g:if test ="${params.action == "list"}"><h1>收件箱<g:link action="senderList">发件箱</g:link></h1></g:if>
			<g:else><h1>发件箱 <g:link action ="list">收件箱</g:link></h1></g:else>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>	
			 <table class="table">
        <thead>
          <tr>
            <g:if test ="${params.action == "list"}"><th class="span2">发信人</th></g:if>
            <g:else><th class="span2">收信人</th></g:else>
            <th class="span6">内容</th>
            <th class="span2">沟通状态</th>
            <th class="span2">借书操作</th>
          </tr>
        </thead>
        
        <tbody>
        <g:each in="${internalMessageInstanceList}" status="i" var="internalMessageInstance">
                    <tr class="message_list">
                    
            <td>
	    <img src="http://tp1.sinaimg.cn/2536625632/50/40004201173/1" class="img-circle" style="width: 50px;"><br>
         <g:if test ="${params.action == "list"}">   ${fieldValue(bean: internalMessageInstance, field: "sender.username")}</g:if>
         <g:else>${fieldValue(bean: internalMessageInstance, field: "recipient.username")}</g:else>
             </td>
            <td><g:link action="show" id="${internalMessageInstance.id}">  ${fieldValue(bean: internalMessageInstance, field: "message")}  <g:if test="${internalMessageInstance.statue&&params.action=="list"}">  <span class="badge badge-info">未读</span></g:if></a>
                           </g:link><br />
              <small>${fieldValue(bean: internalMessageInstance, field: "dateCreated")}</small></td>
            <td><g:if test="${internalMessageInstance?.borrow?.borrowStatus==0}">
                	拥有者已拒绝！
                </g:if>
                <g:if test="${internalMessageInstance?.borrow?.borrowStatus==2}">
                	已申请<br/>
                </g:if>
                <g:if test="${internalMessageInstance?.borrow?.borrowStatus==3}">
                	正在交付<br/>
                </g:if>
                <g:if test="${internalMessageInstance?.borrow?.borrowStatus==4}">
                	已借阅<br/>
                </g:if>
                <g:if test="${internalMessageInstance?.borrow?.borrowStatus==5}">
                	已归还
                </g:if>
            </td>
            <td>
            	<g:if test="${internalMessageInstance?.borrow?.borrowStatus==2}">
            	<g:if test="${params.action=="list"}">
            		<g:link action = "borrowBook" params="[borrowStatusId:'1',internalMessageId:internalMessageInstance.id]"><small>同意借阅</small></g:link><br>
                	<g:link action = "borrowBook"  params="[borrowStatusId:'0',internalMessageId:internalMessageInstance.id]"> <small>不同意借阅</small></g:link>
                </g:if><g:else>
                	等待对方同意
                </g:else>
                </g:if>
                <g:if test="${params.action=="list"&&!internalMessageInstance?.borrow?.ownerAck}">
                	<g:if test="${internalMessageInstance?.borrow?.borrowStatus==3}">
                		<g:link action="borrowAck" params="[internalMessageId:internalMessageInstance.id]">确认交付</g:link>
                	</g:if>
               		 <g:if test="${internalMessageInstance?.borrow?.borrowStatus==4}">
                		 <g:link action="backAck" params="[internalMessageId:internalMessageInstance.id]">确认归还</g:link>
            	    </g:if>
                </g:if>
                <g:if test="${params.action=="list"&&internalMessageInstance?.borrow?.ownerAck&&!internalMessageInstance?.borrow?.borrowerAck}">
          			      等待对方确认
                </g:if>
               
               <g:if test="${params.action!="list"&&!internalMessageInstance?.borrow?.borrowerAck}">
                	<g:if test="${internalMessageInstance?.borrow?.borrowStatus==3}">
                		<g:link action="borrowAck" params="[internalMessageId:internalMessageInstance.id]">确认交付</g:link>
                	</g:if>
               		 <g:if test="${internalMessageInstance?.borrow?.borrowStatus==4}">
                		 <g:link action="backAck" params="[internalMessageId:internalMessageInstance.id]">确认归还</g:link>
            	    </g:if>
                </g:if>
                <g:if test="${params.action!="list"&&internalMessageInstance?.borrow?.borrowerAck&&!internalMessageInstance?.borrow?.ownerAck}">
          		       等待对方确认
                </g:if>
                
              </td>
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
