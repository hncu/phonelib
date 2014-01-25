<%@ page import="phonelibv2.ShiroUser" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main2">
		<g:set var="entityName" value="${message(code: 'shiroUser.label', default: 'ShiroUser')}" />
		<title>欢迎加入我们</title>
		<style type="text/css">
#l-map{ height: 300px;float:left;border:2px solid #bcbcbc;}
#r-result{float:left;}
img{
   max-width:none;
}
</style>
	</head>
	<body>
<div class="container">
  <div class="row-fluid"> 
    <div class="span9">
      <div class="well">
<hr>
        <div class="tabbable tabs-left">
              <ul class="nav nav-tabs">
                <li ><a href="/phonelibV2/signup/accout/1">基本资料</a></li>
                <li ><g:link url="/phonelibV2/signup/accout/2">我的头像

</g:link></li>
                <li class="active"><a href="#">我的地图</a></li>
                <li class="divider"><hr></li>
                <li ><a href="/phonelibV2/signup/accout/4">修改密码</a></li>
                <li ><a href="/phonelibV2/signup/accout/5">登陆绑定</a></li>    

          </ul>
              <div class="tab-content">
    <div id="legend" class="">
      <legend class="">我的地图</legend>
    </div>

<div id="l-map" class="span8"></div>
<div id="r-result" class="span3">
    <br>
    <input type="button" class="btn btn-primary btn-success" onclick="save_lbs();" value="保存我的位置" />
    <br><br><small>只需指定大概位置即可，不会涉及您的隐私</small>
    <input type="hidden" id="lng" value="86.845561"><input type="hidden" id="lat"  value="43.113405">
</div>
<div style="clear: both"></div>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=0922d0fab99abaf440dd4b167f694358"></script>
<script type="text/javascript">
// 百度地图API功能
map = new BMap.Map("l-map");
map.addControl(new BMap.NavigationControl());  //添加默认缩放平移控件
map.addControl(new BMap.NavigationControl({anchor: BMAP_ANCHOR_TOP_RIGHT, type: 

BMAP_NAVIGATION_CONTROL_SMALL}));  //右上角，仅包含平移和缩放按钮
map.addControl(new BMap.NavigationControl({anchor: BMAP_ANCHOR_BOTTOM_LEFT, 

type: BMAP_NAVIGATION_CONTROL_PAN}));  //左下角，仅包含平移按钮
map.addControl(new BMap.NavigationControl({anchor: BMAP_ANCHOR_BOTTOM_RIGHT, 

type: BMAP_NAVIGATION_CONTROL_ZOOM}));  //右下角，仅包含缩放按钮
map.enableScrollWheelZoom(true);
var point = new BMap.Point(116.404, 39.915);
var myCity = new BMap.LocalCity();
myCity.get(mycitySet);
map.addEventListener("dragend", function showInfo(){
    var pointer = map.getCenter();
    marker.setPosition(pointer);
    $("#lng").val(pointer.lng);
    $("#lat").val(pointer.lat);
});
function mycitySet(result){
    point = new BMap.Point(result.center.lng,result.center.lat);
    
    make_overlay(point);
}
function make_overlay(point) {
    map.centerAndZoom(point, 12);
    marker = new BMap.Marker(point);
    map.addOverlay(marker);              // 将标注添加到地图中
    marker.enableDragging();    //可拖拽
    var label = new BMap.Label("拖拽到你经常活动地区<br>点击右侧保存",

{offset:new BMap.Size(20,-10)});
    marker.setLabel(label);
    marker.addEventListener("dragend", function set_lbs(e){
        $("#lng").val(e.point.lng);
         $("#lat").val(e.point.lat);
    }); 
}
function save_lbs() {
    var lng = $("#lng").val();
    var lat = $("#lat").val();
    $.ajax({
        type: "get",
        //url: "/phonelibV2/sigup/map_set/"+lng+'/'+lat,
        url: "/phonelibV2/signup/map_set?lng="+lng+'&lat='+lat,
        dataType:"json",
        success: function(msg){
             if (msg ==1) {
                 window.location.href='/phonelibV2/signup/accout/3';
             }
        }
     });
}
</script>               </div>
        </div>
        </div>
    </div>
    
   
    </div> </div> 
    
 
	</body>
</html>
