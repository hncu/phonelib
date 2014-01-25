$(function(){ //相当于 $(document).ready(function(){
    var path = $("#path").val();
    $("#c_username").blur( username,function () { 
    var username = $("#c_username").attr("value");  
    $.ajax({
        url:"/phonelibV2/signup/createJS",
        data:{"username":username},
        type:"POST",
        success:function(data){
           if(data==1){alert("用户名已存在");}
           else{alert("aa");}
        }
    });
    // alert(username); 
    });
});


