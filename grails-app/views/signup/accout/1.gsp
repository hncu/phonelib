<%@ page import="phonelibv2.ShiroUser" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main2">
		<g:set var="entityName" value="${message(code: 'shiroUser.label', default: 'ShiroUser')}" />
		<title>欢迎加入我们</title>
	</head>
	<body>
	<input type="hidden" id="path" value="${resource() }"/>
<div class="container">
  <div class="row-fluid"> 
    <div class="span9">
      <div class="well">
<hr>
        <div class="tabbable tabs-left">
              <ul class="nav nav-tabs">
                <li class="active"><a href="#">基本资料</a></li>
                <li ><g:link url="/phonelibV2/signup/tx">我的头像</g:link></li>
                <li class="divider"><hr></li>
                <li ><a href="/phonelibV2/signup/accout/4">修改密码</a></li>
                <li ><a href="/phonelibV2/signup/accout/5">登陆绑定</a></li>              </ul>
              <div class="tab-content">
    <form class="form-horizontal" id="myform" action="grzl" method="post">
    <input type="hidden" value="1" name="dosubmit">
    <input type="hidden" value="home/edit_profile/1" name="direct" >
    <div id="legend" class="">
      <legend class="">基本资料</legend>
    </div>
    <div class="control-group">
      <label class="control-label"><font color="#FF0000">*</font>昵称</label>
      <div class="controls">
        <input type="text" class="input-xlarge" onblur="check_nick()" id="nickname"  name="nickname"  value="${userInstance?.nickname }">
        <span id="for_nick"></span> </div>
    </div>
    <div class="control-group">
      <label  class="control-label"><font color="#FF0000">*</font>真实姓名</label>
      <div class="controls">
        <input type="text" class="input-xlarge" id="name" onblur="check_name()" name="realname" value="${userInstance?.realname }">
        <span id="for_name"></span>
      </div>
    </div>
    <div class="control-group">
      <label class="control-label"><font color="#FF0000">*</font>Email<span id="email_status">
                </span></label>
      <div class="controls">
        <input type="text" id="email" class="input-xlarge" onblur="javascript:check_email()"  name="email"  value="${userInstance?.email }">
         <span id="for_email"></span>     
              </div>
              <div class="controls">
     <span id="email_tip"><a href="javascript:send_email()">点击发送验证邮件</a>，没有收到请检查垃圾箱</span>
                </div>
    </div>
     <div class="control-group">
      <label  class="control-label">新浪微博</label>
      <div class="controls">
        <input type="text" class="input-xlarge" name="weibo"  value="${userInstance?.weibo }"> <font color="grey">如：http://weibo.com/ycpai</font>
      </div>
    </div>
     <div class="control-group">
      <label  class="control-label">QQ</label>
      <div class="controls">
        <input type="text" class="input-xlarge" name="qq" value="${userInstance?.qq }">
      </div>
    </div>
     <div class="control-group">
      <label  class="control-label">微信</label>
      <div class="controls">
        <input type="text" class="input-xlarge" name="weixin"  value="${userInstance?.weixin}">
      </div>
    </div>
     <hr>
    <div class="control-group"> 
      
      <!-- Prepended text-->
      <label class="control-label"><font color="#FF0000">*</font>所在地区</label>
      <div class="controls">
        <div class="input-prepend" onblur="javascript:check_location">
<select name="province" onChange = "select()" id="province" accesskey=""></select>　 
<select name="city" onChange = "select()" id="city" accesskey="" ></select>
<br/>
<input  type="hidden" name="province_h" id="province_h" value="${userInstance?.province}"/>
<input  type="hidden" name="city_h" id="city_h" value="${userInstance?.city}"/>
        </div>
        <p class="help-block"></p>
      </div>
    </div>
    <div class="control-group">
      <label class="control-label">性别</label>
      <div class="controls"> 
        <!-- Inline Radios -->
        <label class="radio inline">
        <input type="hidden" id="gender3" value="${userInstance?.sex}"/>
          <input type="radio"  value="1" name="sex" id="gender1"  checked='checked' />
          男 </label>
        <label class="radio inline">
          <input type="radio" value="2" name="sex" id="gender2" />
          女 </label>
      </div>
    </div>
    <div class="control-group">
          <label class="control-label"></label>
          <div class="controls"><p id="sub_tip" style=" color:red"></p>
          </div>
    </div>
    <input type="hidden" id="can_sub" value="1" />

    <div class="control-group">
          <label class="control-label"></label>

          <!-- Button -->
          <div class="controls">
      <a href="javascript:sub_profile()" class="btn btn-primary ">提交</a>
      </div>
    </div>
</form>

<script type="text/javascript">
function sub_profile(){
		
        var nick = $("#nickname").val();
        if(nick ==''){
               // $("#sub_tip").html("请填写昵称");
                return;		
        }
        var cansub = $("#can_sub").val();
        if(cansub == 0){
                //$("#sub_tip").html("昵称已被占用");
                return;	
        }
        if(cansub == 2){
                //$("#sub_tip").html("邮箱已被占用");
                return;	
        }
        var emails = $("#email").val();
    if(emails == ''){
      //  $("#sub_tip").html("请填写邮箱");
        return;
    }
        var city = $("#city").val();
    if(city == 0){
        //$("#sub_tip").html("请填写城市");
        return;
    }

    
    $("#myform").submit();
}
</script>
              </div>
        </div>
        </div>
    </div>
    <div class="span3">
</div>


<footer class="footer">

   
</footer>
    </div>
    
 <script type="text/javascript"  src="/phonelibV2/js/douban_api.js"></script>
<!--start of feedback code powered by geekui-->
<script type="text/javascript" src="/phonelibV2/js/signup/accout/common_foot.js"></script>
<script type="text/javascript" src="/phonelibV2/js/signup/accout/utils.js"></script>


	</body>
</html>
