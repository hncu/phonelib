<%@ page import="phonelibv2.ShiroUser" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main2">
		<g:set var="entityName" value="${message(code: 'shiroUser.label', default: 'ShiroUser')}" />
		<title>欢迎加入我们</title>
	</head>
	<body>
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
                <form class="form-horizontal" id="myform" action="http://www.ycpai.com/home/save_profile" method="post">
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
<script type="text/javascript">
function sub_profile(){
        var nick = $("#nickname").val();
        if(nick ==''){
                $("#sub_tip").html("请填写昵称");
                return;		
        }
        var cansub = $("#can_sub").val();
        if(cansub == 0){
                $("#sub_tip").html("昵称已被占用");
                return;	
        }
        if(cansub == 2){
                $("#sub_tip").html("邮箱已被占用");
                return;	
        }
        var emails = $("#email").val();
    if(emails == ''){
        $("#sub_tip").html("请填写邮箱");
        return;
    }
        var city = $("#city").val();
    if(city == 0){
        $("#sub_tip").html("请填写城市");
        return;
    }
    $("#myform").submit();
}
</script>              </div>
        </div>
        </div>
    </div>
    <div class="span3">
		     <div class="alert fade in"><a class="close" data-dismiss="alert" href="#">×</a>哥们，你的个人介绍太简单了，没办法向别人推荐你啊！<a href="http://www.ycpai.com/home/step1">去完善一下吧</a> </div>		
               <div class="alert fade in"><a class="close" data-dismiss="alert" href="#">×</a><a href="/home/edit_profile/9">设置您的学校和家乡，找校友和老乡</a> </div>	
     	<div id="view_tip"></div>
	<div id="follower_tip"></div>
	<div id="project_follower_tip"></div>
	<div id="need_confirm_tip"></div>
	<div id="have_confirm_tip"></div>
	<div id="team_invint"></div>
	<div id="new_judge_tip"></div>
	<div id="set_map_tip"></div>
	<div><div class="alert fade in" style="text-align:center;"><a class="close" data-dismiss="alert" href="#">×</a>
	<a href="http://www.ycpai.com/app/download"><img src="http://www.ycpai.com/statics/images/android.png"> <img src="http://www.ycpai.com/statics/images/ios.png">十秒钟安装手机客户端，有人联系您，立刻就能收到消息</a> </div></div>    <script type="text/javascript">
    </script>  <div id="left_ychui"></div>
<script type="text/javascript">
     $(function(){
	get_ychui();
    });
    //获取一条问题
    function get_ychui() {
        $.ajax({
            type: "get",
            url: "http://www.ycpai.com/ychui/ajax_left",
            success: function(msg){
                    if (msg.length>2) {
		      $("#left_ychui").html(msg);
                    }
            }
         });
    }
      </script>  <div class="well">
    <div class="nav nav-list">
      我的<a href="http://www.ycpai.com/active/show_credit">靠谱指数</a>:
      <img src='http://www.ycpai.com/statics/images/star.png'/><img src='http://www.ycpai.com/statics/images/stargray.png'/><img src='http://www.ycpai.com/statics/images/stargray.png'/><img src='http://www.ycpai.com/statics/images/stargray.png'/><img src='http://www.ycpai.com/statics/images/stargray.png'/>     <br>
	&nbsp<a href="http://www.ycpai.com/huodong/kaopu_index"><small>如何增加靠谱指数</small></a>
    </div>
  </div>
  <div class="well">
    <ul class="nav nav-list">
      <li class="nav-header">个人中心 </li>
      <li> <a href="http://www.ycpai.com/active/message"> <i class="icon-envelope"></i> <strong>合伙人站内信</strong> <span class="badge badge-info msg_num hide"></span> </a> </li>
      <li> <a href="http://www.ycpai.com/active/comment_manage"> <i class="icon-comment"></i> 相互评价管理 </a> </li>
      <li class="divider"></li>
      
      <li > <a href="http://www.ycpai.com/home/follow_person"> <i class="icon-eye-open"></i> 我关注的合伙人 </a> </li>
      <li > <a href="http://www.ycpai.com/home/follow_project"> <i class="icon-heart"></i> 关注的创业项目 </a> </li>
      <li class="divider"></li>
      <li><li class="dropdown"><a href="http://www.ycpai.com/home/person/24577"><i class="icon-home"></i> 个人主页</li></a></li>
      <li><a href="http://www.ycpai.com/home/edit_profile"><i class="icon-file-alt"></i>  修改个人资料</a></li>
      <li > <a href="http://www.ycpai.com/home/my_project"> <i class="icon-list-alt"></i> 创业项目添加编辑 </a> </li>
    </ul>
  </div>
  <div id="left_huodong"></div>
<script type="text/javascript">
     $(function(){
	get_huodong();
    });
    //获取一条问题
    function get_huodong() {
        $.ajax({
            type: "get",
            url: "http://www.ycpai.com/huodong/ajax_left",
            success: function(msg){
                    if (msg.length>2) {
		      $("#left_huodong").html(msg);
                    }
            }
         });
    }
      </script>  <div class="well">
  微信公众号：yuanchuangpai
</div>
     <div class="well"> <a href="http://www.ycpai.com/home/reliable" class="btn btn-success">申请成为靠谱合伙人</a>
    <li>查看靠谱合伙人信息</li>
    <li>优先参加小规模封闭活动</li>
    <li>搜索结果列表靠前</li>
    <li>加入靠谱合伙人微信群</li>
  </div>
    <div class="modal hide" id="useCard">
    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal">关闭</button>
      <h3>使用充值卡</h3>
    </div>
    <div class="modal-body">
      <div class="input-append">
        <form class="form-horizontal" id="myform1" action="http://www.ycpai.com/huodong/to_show" method="post">
          <input class="span10" id="k_card_pass" name="card_pass" type="text" placeholder="输入刮开的充值卡密码">
          <button class="btn" type="button" onClick="sub_form()">充值</button>
        </form>
        <script type="text/javascript">
        	function sub_form(){
			var pass = $("#k_card_pass").val();
			if(pass==''){
				$("#k_card_pass").focus();	
				return;
			}	
			$("#myform1").submit();
		}
        </script> 
      </div>
    </div>
  </div>
</div>
</div>  </div>
<script type="text/javascript">
</script>

<hr>
<footer class="footer">
      <div align="center"><p>
</p><p>
    
        <a href="/index/contact_us">联系我们</a>  | <a href="http://www.ycpai.com/app/download" target="_blank">安装手机客户端</a> | © 缘创派 2012-2013  |  帮助创业者建立了<strong id='connect_num'>0</strong>对联系<br>
	<p style="text-align: center; color: gray; font-size: small">京ICP备 13045110号</p>
 
          
</p>
    </div>
   
</footer>
    </div>
    
 <script type="text/javascript"  src="/phonelibV2/js/douban_api.js"></script>
<!--start of feedback code powered by geekui-->
<script type="text/javascript" src="/phonelibV2/js/signup/accout/common_foot.js"></script>
<script type="text/javascript" src="/phonelibV2/js/signup/accout/utils.js"></script>
<script type="text/javascript" charset="utf-8">
      $(document).ready(function(){
	 $('#pre_achieve').popover('animation');
	get_statics();
		get_new_message();
	//get_new_users();
	//get_degree();
	get_position()  //获取我的位置
	//get_day_rand();  //获取每日推荐
	get_new_follower_num();
	get_new_project_follower_num();
	get_need_confirm();
	get_have_confirm();
	get_team_invint();
	get_team_confirm();
	get_be_view_num();
	get_ajax_judge();
	get_team_apply();
	setInterval(get_new_message, 60000);
	      });
	var options = {};
	options.company_sub_url = "ycpai";
	options.placement = "bottom_right";
	options.tab_define = false;
	options.display = "overlay";
	options.style = "green_bottom_right.gif";
	var feedback_widget = new GKFN.feedback_widget(options);
</script>
<!--end of feedback code powered by geekui-->
<div style="display:none;"><script type="text/javascript" src="http://tajs.qq.com/stats?sId=23438153" charset="UTF-8"></script></div>
<!-- Baidu Button BEGIN -->
<div id="bdshare" class="bdshare_t bds_slide get-codes-bdshare" data="{'url':'http://www.ycpai.com'}"></div>
<script type="text/javascript" id="bdshare_js" data="type=slide&amp;img=3&amp;pos=right&amp;uid=601492" ></script>
<script type="text/javascript" id="bdshell_js"></script>
<script type="text/javascript">
        /**
	 * 在这里定义bds_config
	 */
	var bds_config = {
		'bdDes':'缘创派-找互联网合伙人',		//'请参考自定义分享摘要'
		'bdText':'我正在使用一个很有意思的网站，缘创派。里面都是想做互联网创业的人，做技术的、产品、设计的都不少，人也很靠谱。如果你有互联网创业的想法，最好也进来看看。 http://www.ycpai.com',		//'请参考自定义分享内容'
		'bdPopTitle':'分享给好友',	//'请参考自定义pop窗口标题'
		//'bdTop':'您的自定义侧栏高度',		//'请参考自定义侧栏高度'
		//'bdComment':'您的自定义分享评论',	//'请参考自定义分享评论'
		'bdPic':'http://www.ycpai.com/statics/images/forshare.jpg',	//'请参考自定义分享出去的图片'
		//'searchPic':'是否自动抓取页面图片',//'0为抓取，1为不抓取，默认为0，目前只针对新浪微博'
		//'wbUid':'您的自定义微博 ID',		//'请参考自定义微博 id'
		//'render':false,				//'请参考自定义分享回流量统计'
		'review':'normal',			//'请参考自定义分享回流签名'
		//'snsKey':{'tsina':'appkey'}		//'请参考自定义分享到平台的appkey'
                'url':'http://www.ycpai.com'
	}
document.getElementById("bdshell_js").src = "http://bdimg.share.baidu.com/static/js/shell_v2.js?cdnversion=" + Math.ceil(new Date()/3600000);
</script>
<!-- Baidu Button END -->  
	</body>
</html>
