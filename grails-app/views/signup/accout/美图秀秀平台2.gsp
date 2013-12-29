<%@ page import="phonelibv2.ShiroUser"%>
<!doctype html>
<html>
<head>
<meta name="layout" content="main2">
<g:set var="entityName"
	value="${message(code: 'shiroUser.label', default: 'ShiroUser')}" />
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
							<li><a href="/phonelibV2/signup/accout/1">基本资料</a></li>
							<li class="active"><g:link url="#">我的头像</g:link></li>
							<li><a href="/phonelibV2/signup/accout/3">我的地图</a></li>
							<li class="divider"><hr></li>
							<li><a href="/phonelibV2/signup/accout/4">修改密码</a></li>
							<li><a href="/phonelibV2/signup/accout/5">登陆绑定</a></li>
						</ul>
						<div class="tab-content">
							<script src="http://open.web.meitu.com/sources/xiuxiu.js"
								type="text/javascript"></script>
							<script type="text/javascript">
								//如果指定id，则参数归各编辑所属(如下例中设置两个编辑器的上传按钮的不同文字标签)
								xiuxiu.setLaunchVars("uploadBtnLabel", "保存",
										"lite");
								xiuxiu.setLaunchVars("uploadBtnLabel", "上传",
										"collage");
								//如果未指定id，则参数为所有编辑器共有(如下例中设置两个编辑器都是繁体中文)
								xiuxiu.setLaunchVars("language", "zh_tw");
								xiuxiu.embedSWF("altContent1", 5, 700, 400,
										"lite");

								xiuxiu.onInit = function(id) {
									xiuxiu
											.loadPhoto(
													"http://open.web.meitu.com/sources/images/1.jpg",
													false, id);
									xiuxiu
											.setUploadURL(
													"http://127.0.0.1:8080/phonelibV2/signup/photo",
													id);
									xiuxiu.setUploadType(1, id);
								}

								xiuxiu.onUploadResponse = function(data, id) {
									var msg = "上传响应";
									if (id == "lite") {
										msg = "轻量编辑M2" + msg;
									} else if (id == "collage") {
										msg = "轻量拼图M3" + msg;
									}
									alert(msg + data);
								}

								xiuxiu.onDebug = function(data, id) {
									alert("错误响应" + data);
								}

								xiuxiu.onClose = function(id) {
									//alert(id + "关闭");
									//根据id判断，各关各的
									clearFlash();
								}

								//清除flash
								function clearFlash() {
									document.getElementById("flashEditorOut").innerHTML = '<div id="flashEditorContent"><p><a href="http://www.adobe.com/go/getflashplayer"><img alt="Get Adobe Flash player" src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif"></a></p></div>';
								}
							</script>
							<div id="legend" class="">
								<legend class="">我的头像</legend>
							</div>

							<div id="flashEditorOut">
								<div id="altContent1"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>



	</div>
</body>
</html>
