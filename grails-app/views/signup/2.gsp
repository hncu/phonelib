<%@ page import="phonelibv2.ShiroUser" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main2">
		<g:set var="entityName" value="${message(code: 'shiroUser.label', default: 'ShiroUser')}" />
		<title>欢迎加入我们</title>
		
<style type="text/css" media="screen">
  html, body { height:100%; background-color: #ffffff;}
  #flashContent { width:100%; height:100%; }
  </style>
	
	<script type="text/javascript">
   function uploadevent(status,picUrl,callbackdata){
  //alert(picUrl); //后端存储图片
//	alert(callbackdata);
        status += '';
     switch(status){
     case '1':
		var time = new Date().getTime();
		var filename162 = picUrl+'_162.jpg';
		var filename48 = picUrl+'_48.jpg';
		var filename20 = picUrl+"_20.jpg";

		//document.getElementById('avatar_priview').innerHTML = "头像1 : <img src='"+filename162+"?" + time + "'/> <br/> 头像2: <img src='"+filename48+"?" + time + "'/><br/> 头像3: <img src='"+filename20+"?" + time + "'/>" ;
		
	break;
     case '-1':
	  window.location.reload();
     break;
     default:
     window.location.reload();
    } 
   }
  </script>	
		
	</head>
	<body>
<div class="container">
  <div class="row-fluid"> 
    <div class="span9">
      <div class="well">
<hr>
        <div class="tabbable tabs-left">
						<ul class="nav nav-tabs">
							<li><a href="/phonelibV2/signup/accout/1">基本资料</a></li>
							<li class="active"><g:link url="#">我的头像</g:link></li>
							<li class="divider"><hr></li>
							<li><a href="/phonelibV2/signup/accout/4">修改密码</a></li>
							<li><a href="/phonelibV2/signup/accout/5">登陆绑定</a></li>
						</ul>
              <div class="tab-content">

    <div id="legend" class="">
      <legend class="">我的头像</legend>
    </div>
    
      <div id="altContent">


<OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,40,0"
WIDTH="650" HEIGHT="450" id="myMovieName">
<PARAM NAME=movie VALUE="/phonelibV2/js/signup/accout/avatar.swf">
<PARAM NAME=quality VALUE=high>
<PARAM NAME=bgcolor VALUE=#FFFFFF>
<param name="flashvars" value="imgUrl=/phonelibV2/js/signup/accout/default.jpg&uploadUrl=touxiang&uploadSrc=false" />
							   
<EMBED src="/phonelibV2/js/signup/accout/avatar.swf" quality=high bgcolor=#FFFFFF WIDTH="650" HEIGHT="450" wmode="transparent" flashVars="imgUrl=/phonelibV2/js/signup/accout/default.jpg&uploadUrl=touxiang&uploadSrc=false"
NAME="myMovieName" ALIGN="" TYPE="application/x-shockwave-flash" allowScriptAccess="always"
PLUGINSPAGE="http://www.macromedia.com/go/getflashplayer">
</EMBED>
</OBJECT>
 

  </div>

  <div id="avatar_priview"></div>
    
    
    
     </div>
      </div>
       </div>
        </div>
         </div>
          </div>
    
	</body>
</html>
