<%@ page import="phonelibv2.ShiroUser"%>
<!doctype html>
<html>
<head>
	
<meta name="layout" content="main2">
<g:set var="entityName"
	value="${message(code: 'shiroUser.label', default: 'ShiroUser')}" />
<title>欢迎加入我们</title>
	<link rel="stylesheet" type="text/css" href="/phonelibV2/js/signup/accout/imgareaselect-default.css" />
	
	<script type="text/javascript">
function AutoResizeImage(maxWidth,maxHeight,objImg){
var img = new Image();
img.src = objImg.src;
var hRatio;
var wRatio;
var Ratio = 1;
var w = img.width;
var h = img.height;
wRatio = maxWidth / w;
hRatio = maxHeight / h;
if (maxWidth ==0 && maxHeight==0){
Ratio = 1;
}else if (maxWidth==0){//
if (hRatio<1) Ratio = hRatio;
}else if (maxHeight==0){
if (wRatio<1) Ratio = wRatio;
}else if (wRatio<1 || hRatio<1){
Ratio = (wRatio<=hRatio?wRatio:hRatio);
}
if (Ratio<1){
w = w * Ratio;
h = h * Ratio;
}
objImg.height = h;
objImg.width = w;
}
</script>
	
<style type="text/css">
#img{
height:300px;
}
#img .hull{
width:400px;
}
#localImag{
height:300px;
width:200px;
border:1px solid #ccc;
float: left;
}
#show_img{
float: right;
}
#old_img img{
width:200px;
height:300px;
}
</style>
<script type="text/javascript">
/*
* setImagePreview()
* @param fileObj Strimg 表示上传域的ID
* @param previewObj String 表示显示图片的ID
* @param localImg String 表示显示图片外层的div的ID
* @param width 表示显示图片的宽
* @param height 表示显示图片的高
*/
function setImagePreview(fileObj, previewObj, localImg,width,height)
{
var docObj=document.getElementById(fileObj);
var imgObjPreview=document.getElementById(previewObj);
if(docObj.files && docObj.files[0]){
//火狐下，直接设img属性
imgObjPreview.style.display = 'block';
imgObjPreview.style.width = width+'px';
imgObjPreview.style.height = height+'px';
//imgObjPreview.src = docObj.files[0].getAsDataURL();
//火狐7以上版本不能用上面的getAsDataURL()方式获取，需要一下方式
imgObjPreview.src =
window.URL.createObjectURL(docObj.files[0]);
}else{
//IE下，使用滤镜
docObj.select();
var imgSrc = document.selection.createRange().text;
var localImagId = document.getElementById(localImg);
//必须设置初始大小
localImagId.style.width = width+'px';
localImagId.style.height = height+'px';
//图片异常的捕捉，防止用户修改后缀来伪造图片
try{
localImagId.style.filter="progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
localImagId.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = imgSrc;
}catch(e){
alert("您上传的图片格式不正确，请重新选择!");
return false;
}
imgObjPreview.style.display = 'none';
document.selection.empty();
}
return true;
}
$(function(){
//给上传区添加onchang事件，掉用函数setImagePreview()
$("#Member_headimg").change(function() {
setImagePreview('Member_headimg','preview','localImag',200,300);
setImagePreview('Member_headimg','small_photo','small_img',75,
75);
setImagePreview('Member_headimg','big_photo','big_img',100,100)
;
})
})
</script>


	<div class="container">
		<div class="row-fluid">
			<div class="span9">
				<div class="well">
					<hr>
					<div class="tabbable tabs-left">
						<ul class="nav nav-tabs">
							<li><a href="/phonelibV2/signup/accout/1">基本资料</a></li>
							<li class="active"><g:link url="#">我的头像</g:link></li>
							<li><a href="/phonelibV2/signup/accout/3">我的地图</a></li>
							<li class="divider"><hr></li>
							<li><a href="/phonelibV2/signup/accout/4">修改密码</a></li>
							<li><a href="/phonelibV2/signup/accout/5">登陆绑定</a></li>
						</ul>
						<div class="tab-content">
						
						<div class="main_right_mr">
<h2>头像设置</h2>
<div class="headimg_form">
<g:uploadForm action="upload" method="post" >
<input type="file" id="Member_headimg" name="Member_headimg" />


<input type="submit" id = "q" value="上传">
</g:uploadForm>
</div>
<div id="img">
<div class="hull">
<div id="localImag" ><img id="preview" width=-1 height=-1 style="diplay:none" /></div>
<div id="show_img" >
<p>大头像</p>
<div style="height:100px;width:100px;border:1px solid
#ccc;overflow:hidden;"><div id="big_img"
style="height:100px;width:100px;border:1px solid
#ccc;overflow:hidden;"><img id="big_photo" width=-1 height=-1
style="diplay:none" /></div></div>
<br/>
<p>小头像</p>
<div style="height:75px;width:75px;border:1px solid
#ccc;overflow:hidden;"><div id="small_img"
style="height:75px;width:75px;border:1px solid
#ccc;overflow:hidden;"><img id="small_photo" width=-1 height=-1
style="diplay:none" /></div></div>


<p><input type="button"  id = "test_post"value="确认修改" /></p>



</div>
</div>
</div>
						</div>
					</div>
				</div>
			</div>
		</div></div>



	</div>

</body>
</html>
