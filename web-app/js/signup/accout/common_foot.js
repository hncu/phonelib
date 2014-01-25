var flag=true;
// var domain_url = 'http://www.ycpai.com/';
var domain_url = $("#path").val();




//验证昵称11111111111111
function check_nick(){
	var nick = $.trim($("#nickname").val());
    // alert(nick);
            if(nick ==''){
                $("#for_nick").html('<font color="red">请填写昵称</font>');
                return;     
        } 
	if(nick !=''){
	  $.ajax({
	    type: "get",
	    url: domain_url+"/Signup/uniq_nick/?nick="+encodeURIComponent(nick),
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

//验证真实姓名
function check_name(){
    var name = $.trim($("#name").val());
    if(name == ''){
      $("#for_name").html('<font color="red">请填写你的真实姓名</font>');
      return ;
    }else{
        $("#for_name").html('');
        return ;
    }
}

//验证邮箱
function check_email(){
    var mail = $("#email").val();
    var cans = $("#can_sub").val(); 
    if(mail == ''){
        $("#for_email").html('<font color="red">请填写邮箱</font>');
        return;
    }
    var pattern=/^([a-zA-Z0-9]+[_|\_|\.\-]?)*[a-zA-Z0-9]+@([a-zA-Z0-9\-]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
    if(!mail.match(pattern)){
         $("#for_email").html('<font color="red">邮箱格式不正确</font>');
         $("#can_sub").val(2);
        return;
    }
    $.ajax({
        type: "get",
        url: domain_url+"/Signup/uniq_email?email="+encodeURIComponent(mail),
        dataType:"json",
        async:false,
    /*(默认: true) 默认设置下，所有请求均为异步请求。如果需要发送同步请求，请将此选项设置为 false。
        注意，同步请求将锁住浏览器，用户其它操作必须等待请求完成才可以执行*/
        success: function(msg){
            if(msg){
            $("#for_email").html('<font color="green">邮箱可以使用</font>');
            if(cans==2){
                  $("#can_sub").val(1);     
            }
            }else{
                $("#for_email").html('<font color="red">邮箱已被占用</font>');
                $("#can_sub").val(2);
               return; 
            }
        }
    });     
}

//验证location
function check_location(){
    alert("aaa");
}


