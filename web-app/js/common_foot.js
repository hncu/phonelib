var flag=true;
var domain_url = 'http://www.ycpai.com/';
//获取最新消息
function get_new_message(){
	$.ajax({
	   type: "get",
	   url: domain_url+"active/get_num_new_message",
	   dataType:"json",
	   success: function(msg){
		   if(msg){
			   $(".msg_num").html(msg);
			   $(".msg_num").show();
			   setInterval(flash_meg, 500);
		   }
	   }
	});
}
//获取最新关注自己的人数
function get_new_follower_num(){
	$.ajax({
		type: "get",
		url: domain_url+"active/get_new_follower_num",
		dataType:"json",
		success: function(msg){
			if(msg){
				var inhtml = '<div class="alert fade in" style="text-align:center;"><a class="close" data-dismiss="alert" href="#">×</a><a href="'+domain_url+'home/my_followers">新增'+msg+'个关注者</a> </div>';
				$("#follower_tip").html(inhtml);
			}
		}
	});	
}
//获取需要确认提醒
function get_need_confirm() {
    $.ajax({
	  type: "get",
	  url: domain_url+"kvdb/ajax_need_confirm",
	  dataType:"json",
	  success: function(msg){
		  if(msg){
		      var inhtml='';
		      var len = msg.length;
		      for (var i=0;i<len;i++) {
			    inhtml +='<div class="alert fade in" style="text-align:center;"><a class="close" data-dismiss="alert" href="#">×</a><a href="'+domain_url+'active/talk_list/'+msg[i].user_id+'?act=need">'+msg[i].nick+'更新了和你的沟通状态</a> </div>';
		      }
			  $("#need_confirm_tip").html(inhtml);
		  }
	  }
       });	
}
//用户最新评价提醒
function get_ajax_judge() {
    $.ajax({
	  type: "get",
	  url: domain_url+"kvdb/ajax_get_judge",
	  dataType:"json",
	  success: function(msg){
		  if(msg){
		      var inhtml='';
		      var len = msg.length;
		      for (var i=0;i<len;i++) {
			    inhtml +='<div class="alert fade in" style="text-align:center;"><a class="close" data-dismiss="alert" href="#">×</a><a href="'+domain_url+'active/comment_manage">'+msg[i].nick+'刚刚评价了你</a></div>';
		      }
			  $("#new_judge_tip").html(inhtml);
		  }
	  }
       });	
}
//获取已经确认提醒
function get_have_confirm() {
    $.ajax({
	  type: "get",
	  url: domain_url+"kvdb/ajax_have_confirm",
	  dataType:"json",
	  success: function(msg){
		  if(msg){
		      var inhtml='';
		      var len = msg.length;
		      for (var i=0;i<len;i++) {
			    inhtml +='<div class="alert fade in" style="text-align:center;"><a class="close" data-dismiss="alert" href="#">×</a><a href="'+domain_url+'active/talk_list/'+msg[i].user_id+'?act=have">'+msg[i].nick+'确认了你的沟通状态请求，去评价他</a> </div>';
		      }
			  $("#have_confirm_tip").html(inhtml);
		  }
	  }
       });	
}
//获取最新查看我页面人数
function get_be_view_num() {
    $.ajax({
	  type: "get",
	  url: domain_url+"kvdb/ajax_get_be_view_num",
	  dataType:"json",
	  success: function(msg){
		  if(msg>0){
		     var inhtml ='<div class="alert fade in" style="text-align:center;"><a class="close" data-dismiss="alert" href="#">×</a><a href="'+domain_url+'home/my_viewer/see">'+msg+'人查看了您的资料，去看看</a> </div>';
		     $("#view_tip").html(inhtml);
		  }
	  }
       });	
}
function flash_meg(){
		 if(flag){
			 flag=false;
			document.title='【新消息】';
		 }else{
			 flag=true;
			 document.title=''; 
		}		
}
//获取联系用户数
function get_statics(){
	$.ajax({
	   type: "get",
	   url: domain_url+"common/get_active_num",
	   dataType:"json",
	   success: function(msg){
		   if(msg){
			   $("#connect_num").html(msg);
		   }
	   }
	});
}
//判断是否显示推荐信息
function get_tuijian(){
	$.ajax({
		   type: "get",
		   url: domain_url+"home/get_tuijian",
		   dataType:"json",
		   success: function(msg){
			   if(msg == 1){
				  $("#tuijian_tip").show();
			   }
		   }
		});
}
//关注项目或个人follow_id项目或人ID，type:0用户，1项目
function add_follow(follow_id,type){
	$.ajax({
		type: "get",
		url: domain_url+"active/add_follow/"+follow_id+'/'+type,
		dataType:"json",
		success: function(msg){
			if(msg){
				if(type == 0){
					     $("#for_follow_user").html('<a href="javascript:void(0);" class="btn disabled">已关注</a>');
				}else{
					$("#for_follow_project").html('<a href="javascript:void(0);" class="btn disabled">已关注</a>');
					}
			}else{
				alert('关注失败');
				}
		}
	});
}
//取消关注项目或个人follow_id项目或人ID，type:0用户，1项目
function cacel_follow(follow_id,type){
	$.ajax({
		type: "get",
		url: domain_url+"active/cacel_follow/"+follow_id+'/'+type,
		dataType:"json",
		success: function(msg){
			if(msg){
				window.location.reload();
			}
		}
	});
}
//列表页添加关注
function list_follow(follow_id,type){
	$.ajax({
		type: "get",
		url: domain_url+"active/add_follow/"+follow_id+'/'+type,
		dataType:"json",
		success: function(msg){
			if(msg){
				if(type == 0){
					     $("#for_follow_user_"+follow_id).html('<a href="javascript:void(0);" class="btn btn-small disabled"><i class="icon-ok"></i> 已关注</a>');
				}else{
					$("#for_follow_project_"+follow_id).html('<a href="javascript:void(0);" class="btn btn-small disabled"><i class="icon-ok"></i> 已关注</a>');
					}
			}else{
				alert('关注失败');
				}
		}
	});
}
//获取城市
function get_city(state){
	if(state>0){
		$.ajax({
		   type: "get",
		   url: domain_url+"home/get_city/"+state,
		   dataType:"json",
		   success: function(msg){
			   if(msg){
				var inhtml = '<option value="0">请选择</option>';
				var len = msg.length;
				for(var i=0;i<len;i++){
					inhtml += '<option value="'+msg[i].id+'">'+msg[i].name+'</option>';
				}
				$("#city").html(inhtml);
			   }
		   }
		});
	}else{
		var inhtml = '<option value="0">请选择</option>';
		$("#city").html(inhtml);	
	}
}
//获取最新注册用户
function get_new_users(){
	$.ajax({
	   type: "get",
	   url: domain_url+"home/get_new_user",
	   dataType:"json",
	   success: function(msg){
	        if(msg){
		var userstr='';
			for(var i=0;i<6;i++){
				userstr += '<li class="divider"></li><strong><a target="_blank" href="'+domain_url+'home/person/'+msg[i].id+'">'+msg[i].name+'</a>- '+msg[i].city+' </strong>- '+msg[i].role_type+'<p>'+msg[i].pre_achieve+'...</p>';
			}
			 $("#new_list").html(userstr);
		}
	   }
	});
}
//获取完善程度
function get_degree(){
		$.ajax({
		   type: "get",
		   url: domain_url+"home/get_user_degree",
		   dataType:"json",
		   success: function(msg){
	       $("#degree").html(msg+'%');
		   }
		});
}
//获取每日推荐
function get_day_rand(){
	$.ajax({
	   type: "get",
	   url: domain_url+"active/day_rand_user",
	   dataType:"json",
	   success: function(msg){
		   if(msg == -1){
			    var userstr = '您所在城市今日无合适人选推荐';
			    $("#day_rand_user").html(userstr);  
			}else if(msg){
				var userstr='';
				var src_value = msg.imagepath =='' ? domain_url+'uploadfile/user_img/usrsmall.gif' : msg.imagepath;
				userstr += '<li class="divider"></li><a class="thumbnail" href="'+domain_url+'home/person/'+msg.id+'" style=" border:0"><img width="120" class="img-circle" alt="" src="'+src_value+'"></a>'+
				'<strong><a target="_blank" href="http://www.ycpai.com/home/person/'+msg.id+'">'+msg.name+'</a>- '+msg.city+' </strong>- '+msg.role_type+'<p>'+msg.skill_describe+'</p><p><strong>个人描述:</strong>'+msg.pre_achieve+
				'</p><p><a class="btn btn-primary day_rand" href="javascript:filter_rand('+msg.id+',1);">建立联系</a> <a style=" margin-left:30px" class="btn btn-primary day_rand" href="javascript:filter_rand('+msg.id+',0);">忽略</a><li class="divider"></li>';
			$("#day_rand_user").html(userstr);
		   }else{
			   var userstr = '今日已推荐30人';
			    $("#day_rand_user").html(userstr);
			}
	   }
	});
}
//过滤每日推荐
function filter_rand(user_id,type){
	$(".day_rand").addClass('disabled');
	$.ajax({
		   type: "get",
		   url: domain_url+"active/filter_rand_user"+user_id+"/"+type,
		   dataType:"json",
		   success: function(msg){
		       if(msg == 1){
			    get_day_rand();  
		      }
		   }
		});
}
//异步判断用户是否已经设置地图位置
function get_position(){
	$.ajax({
		type: "get",
		url: domain_url+"home/ajax_get_my_position",
		dataType:"json",
		success: function(msg){
		    if(msg == 1){
			var inhtml = '<div class="alert fade in" style="text-align:center;"><a class="close" data-dismiss="alert" href="#">×</a><a href="'+domain_url+'home/map_set">设置我的位置，找附近的合伙人</a></div>';
			$("#set_map_tip").html(inhtml);
		   }
		}
	});
}
//验证昵称
function check_nick(){
	var nick = $.trim($("#nickname").val());	
	alert("aaaaa");
	var cans = $("#can_sub").val();
	if(nick !=''){
	  $.ajax({
	    type: "get",
	    url: domain_url+"home/uniq_nick/"+encodeURIComponent(nick),
	    dataType:"json",
	    success: function(msg){
		    if(msg){
			$("#for_nick").html('<font color="green">昵称可以使用</font>');
			if(cans==0){
				  $("#can_sub").val(1);		
			}
		    }else{
			   $("#for_nick").html('<font color="red">昵称已被占用</font>');
			   $("#can_sub").val(0);
			   return; 
		    }
	    }
	});
   }
}
//验证邮箱
function check_email(){
	var mail = $("#email").val();
	var cans = $("#can_sub").val();	
	if(mail == ''){
		$("#email_tip").html('<font color="red">请填写邮箱</font>');
		return;
	}
	var pattern=/^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9\-]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	if(!mail.match(pattern)){
	     $("#email_tip").html('<font color="red">邮箱格式不正确</font>');
	     $("#can_sub").val(2);
		return;
	}
	$.ajax({
	    type: "get",
	    url: domain_url+"index/uniq_email/"+encodeURIComponent(mail),
	    dataType:"json",
	    async:false,
	    success: function(msg){
		    if(msg){
			$("#email_tip").html('<font color="green">邮箱可以使用</font>');
			if(cans==2){
				  $("#can_sub").val(1);		
			}
		    }else{
			    $("#email_tip").html('<font color="red">邮箱已被占用</font>');
			    $("#can_sub").val(2);
			   return; 
			}
		}
	});		
}
//分享到新浪或QQ
function user_share(div_id,content){
      var inhtml='';
      inhtml = "<a title='分享到新浪微博' href='";
      inhtml += "javascript:void((function(s,d,e){try{}catch(e){}var f=\"http:\/\/v.t.sina.com.cn/share/share.php?\",u=d.location.href,p=[\"url=\",e(u),\"&amp;title=\",e(\""+content+"\")].join(\"\");function a(){if(!window.open([f,p].join(\"\"),\"mb\",[\"toolbar=0,status=0,resizable=1,width=620,height=450,left=\",(s.width-620)/2,\",top=\",(s.height-450)/2].join(\"\")))u.href=[f,p].join(\"\");};"
      inhtml += "if(/Firefox/.test(navigator.userAgent)){setTimeout(a,0)}else{a()}})(screen,document,encodeURIComponent));";
      inhtml += "'><img src='http://www.ycpai.com/statics/images/share_sina.gif' alt=分享到新浪微博></a> ";
      inhtml += " <a href='";
      inhtml += "javascript:(function(){window.open(\"http://v.t.qq.com/share/share.php?title="+encodeURIComponent(content)+'&amp;url='+encodeURIComponent(location.href)+"&amp;source=bookmark\",\"_blank\",\"width=610,height=350\");})()'";
      inhtml += "title='分享到QQ微博'><img src='http://www.ycpai.com/statics/images/share_qq.gif' alt='分享到QQ微博'></a>";
      $("#"+div_id).html(inhtml);
}
//新浪微博