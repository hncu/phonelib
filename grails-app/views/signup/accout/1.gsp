<%@ page import="phonelibv2.ShiroUser" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main2">
		<g:set var="entityName" value="${message(code: 'shiroUser.label', default: 'ShiroUser')}" />
		<title>欢迎加入我们</title>
		
		<script type="text/javascript" >
function YearMonthDay(){
   fo=document.form1;
   foday=fo.day;
   MonHead=[31,28,31,30,31,30,31,31,30,31,30,31];
  
   //add options for year
   y=new Date().getFullYear();
   for(i=(y-80);i<=y;i++)
   fo.year.options.add(new Option(i,i));
   fo.year.options.value=y;//current year
  
    //add options for month
   m=new Date().getMonth();
   for(i=1;i<=12;i++)
   fo.month.options.add(new Option(i,i));
   fo.month.options.value=m+1;//current month
  
   //add options for day
   d=new Date().getDay();
   n=MonHead[m];
   if(m==1&&IsRunYear(yearValue))
   n++;
   day(n);
   fo.day.options.value=d+1;//curren day
}
   //onchange of year
function yy(str){
   monthValue=fo.month.options[fo.month.selectedIndex].value;
   if(monthValue==""){
      var foday=document.form1.day;
   optionClear(foday);
   return;
    }
   var n=MonHead[monthValue-1];
   if(monthValue==2&&IsRunYear(str)) n++;
   day(n);
}
   //onchange of month
function mm(ab){
  yearValue=fo.year.options[fo.year.selectedIndex].value;
 if(yearValue==""){
  optionClear(foday);
  return;
 }
 var n=MonHead[ab-1];
 if(ab==2&&IsRunYear(yearValue)) n++;
 day(n);
}
  
function day(ab){
   optionClear(foday);
   for(var i=1;i<=ab;i++)
   foday.options.add(new Option(i,i));
 }
 
function optionClear(ab){
   for(var i=ab.options.length;i>0;i--)
   ab.remove(i);
}
function  IsRunYear(year){ 
   return(0==year%4&&(year%100!=0 || year%400==0));
}
</script>
	</head>
	<body onload="YearMonthDay()">
<div class="container">
  <div class="row-fluid"> 
    <div class="span9">
      <div class="well">
<hr>
        <div class="tabbable tabs-left">
              <ul class="nav nav-tabs">
                <li class="active"><a href="#">基本资料</a></li>
                <li ><g:link url="/phonelibV2/signup/tx">我的头像</g:link></li>
                <li ><a href="/phonelibV2/signup/accout/3">我的地图</a></li>
                <li class="divider"><hr></li>
                <li ><a href="/phonelibV2/signup/accout/4">修改密码</a></li>
                <li ><a href="/phonelibV2/signup/accout/5">登陆绑定</a></li>              </ul>
              <div class="tab-content">
                <form class="form-horizontal" id="myform" action="http://www.ycpai.com/home/save_profile" method="post" name=form1>
    <input type="hidden" value="1" name="dosubmit">
    <input type="hidden" value="home/edit_profile/1" name="direct" >
    <div id="legend" class="">
      <legend class="">基本资料</legend>
    </div>
    <div class="control-group">
      <label class="control-label">昵称</label>
      <div class="controls">
        <input type="text" class="input-xlarge" onblur="javascript:check_nick()" id="nickname"  name="info[name]" value="">
        <span id="for_nick"></span> </div>
    </div>
    <div class="control-group">
      <label  class="control-label"><font color="#FF0000">*</font>姓名</label>
      <div class="controls">
        <input type="text" class="input-xlarge" name="info[realname]" value="">
      </div>  </div>

	<div class="control-group">
	<label class="control-label">出生日期</label>
	 <div class="controls">
	<select name=year onchange="yy(this.value)" style="width: 100px">
	<option value=""></option>
	</select> <select name=month onchange="mm(this.value)" style="width: 100px">
	<option value=""></option>
	</select> <select name=day style="width: 100px">
		<option value=""></option>
	</select>
	</div>
		</div>


								<div class="control-group">
      <label class="control-label"><font color="#FF0000">*</font>Email<span id="email_status">
                </span></label>
      <div class="controls">
        <input type="text" id="email" class="input-xlarge" onblur="javascript:check_email()"  name="info[email]"  value="">
                <span id="for_email"><a href="javascript:send_email()">发送验证邮件</a>，没有收到请检查垃圾箱</span>
              </div>
    </div>
     <div class="control-group">
      <label  class="control-label">新浪微博</label>
      <div class="controls">
        <input type="text" class="input-xlarge" name="info[weibo]"  value=""> <font color="grey">如：http://weibo.com/ycpai</font>
      </div>
    </div>
     <div class="control-group">
      <label  class="control-label">QQ</label>
      <div class="controls">
        <input type="text" class="input-xlarge" name="info[qq]" value="">
      </div>
    </div>
     <div class="control-group">
      <label  class="control-label">微信</label>
      <div class="controls">
        <input type="text" class="input-xlarge" name="info[weixin]"  value="">
      </div>
    </div>
     <hr>
    <div class="control-group"> 
      
      <!-- Prepended text-->
      <label class="control-label"><font color="#FF0000">*</font>所在地区</label>
      <div class="controls">
        <div class="input-prepend">
<select name="province" onChange = "select()" id="province"></select>　 
<select name="city" onChange = "select()" id="city"></select>
<br/>
<input  type="hidden" name="local" id="local" />
        </div>
        <p class="help-block"></p>
      </div>
    </div>
    <div class="control-group">
      <label class="control-label">性别</label>
      <div class="controls"> 
        <!-- Inline Radios -->
        <label class="radio inline">
          <input type="radio" value="1" name="info[gender]" id="gender1" checked='checked' >
          男 </label>
        <label class="radio inline">
          <input type="radio" value="2" name="info[gender]" id="gender2"   >
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
         <a href="javascript:sub_profile()" class="btn btn-primary ">提交</a>&nbsp;&nbsp;&nbsp; <a href="/home/edit_profile/1" class="btn">跳过</a>
      </div>
    </div>
</form>
       </div>
        </div>
        </div>
    </div>
     </div>
      </div>

    
 <script type="text/javascript"  src="/phonelibV2/js/douban_api.js"></script>
<!--start of feedback code powered by geekui-->
<script type="text/javascript" src="/phonelibV2/js/signup/accout/common_foot.js"></script>
<script type="text/javascript" src="/phonelibV2/js/signup/accout/utils.js"></script>


	</body>
</html>
